from vanna.core.agent import Agent
from vanna.core.registry import ToolRegistry
from vanna.core.user import UserResolver, User, RequestContext
from vanna.tools import RunSqlTool, VisualizeDataTool
from vanna.tools.agent_memory import SaveQuestionToolArgsTool, SearchSavedCorrectToolUsesTool, SaveTextMemoryTool
from vanna.servers.fastapi import VannaFastAPIServer
from vanna.integrations.ollama import OllamaLlmService
from vanna.integrations.mysql import MySQLRunner
from vanna.integrations.chromadb import ChromaAgentMemory

# LLM
llm = OllamaLlmService(
    model="phi3:mini",
    host="http://ollama:11434"  # for Linux Docker
)

# Database
db_tool = RunSqlTool(
    sql_runner=MySQLRunner(
        host="mysql",
        database="your_database",
        user="your_user",
        password="your_password",
        port=3306
    )
)

# Memory
agent_memory = ChromaAgentMemory(
    collection_name="vanna_memory",
    persist_directory="./chroma_db"
)

# User resolver
class SimpleUserResolver(UserResolver):
    async def resolve_user(self, request_context: RequestContext) -> User:
        user_email = request_context.get_cookie('vanna_email') or 'guest@example.com'
        group = 'admin' if user_email == 'admin_email' else 'user'
        return User(id=user_email, email=user_email, group_memberships=[group])

user_resolver = SimpleUserResolver()

# Tools
tools = ToolRegistry()
tools.register_local_tool(db_tool, access_groups=['admin', 'user'])
tools.register_local_tool(SaveQuestionToolArgsTool(), access_groups=['admin'])
tools.register_local_tool(SearchSavedCorrectToolUsesTool(), access_groups=['admin', 'user'])
tools.register_local_tool(SaveTextMemoryTool(), access_groups=['admin', 'user'])
tools.register_local_tool(VisualizeDataTool(), access_groups=['admin', 'user'])

# Agent
agent = Agent(
    llm_service=llm,
    tool_registry=tools,
    user_resolver=user_resolver,
    agent_memory=agent_memory
)

# Server — just run it
server = VannaFastAPIServer(agent)
server.run(host="0.0.0.0", port=8000, workers=2)

from vanna.core.agent import Agent
from vanna.core.registry import ToolRegistry
from vanna.core.user import UserResolver, User, RequestContext
from vanna.tools import RunSqlTool, VisualizeDataTool
from vanna.tools.agent_memory import SaveQuestionToolArgsTool, SearchSavedCorrectToolUsesTool, SaveTextMemoryTool
from vanna.integrations.ollama import OllamaLlmService
from vanna.integrations.mysql import MySQLRunner
from vanna.integrations.chromadb import ChromaAgentMemory
from vanna.servers.flask import VannaFlaskServer
llm = OllamaLlmService(
    model="recipe-qwen:latest",
    host="http://172.23.0.2:11434"
)
db_tool = RunSqlTool(
    sql_runner=MySQLRunner(
        host="mysql",
        database="your_database",
        user="your_user",
        password="your_password",
        port=3306
    )
)
agent_memory = ChromaAgentMemory(
    collection_name="vanna_memory",
    persist_directory="./chroma_db"
)
class SimpleUserResolver(UserResolver):
    async def resolve_user(self, request_context: RequestContext) -> User:
        user_email = request_context.get_cookie('vanna_email') or 'guest@example.com'
        group = 'admin' if user_email == 'admin_email' else 'user'
        return User(id=user_email, email=user_email, group_memberships=[group])

tools = ToolRegistry()
tools.register_local_tool(db_tool, access_groups=['admin', 'user'])
tools.register_local_tool(SaveQuestionToolArgsTool(), access_groups=['admin'])
tools.register_local_tool(SearchSavedCorrectToolUsesTool(), access_groups=['admin', 'user'])
tools.register_local_tool(SaveTextMemoryTool(), access_groups=['admin', 'user'])
tools.register_local_tool(VisualizeDataTool(), access_groups=['admin', 'user'])

agent = Agent(
    llm_service=llm,
    tool_registry=tools,
    user_resolver=SimpleUserResolver(),
    agent_memory=agent_memory
)
server = VannaFlaskServer(agent)
server.run()  # Access at http://localhost:5000

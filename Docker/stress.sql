USE recipe_db;

SET SESSION group_concat_max_len = 10000000;

SELECT GROUP_CONCAT(full_block SEPARATOR '\n') AS giant_sql_file
FROM (
    SELECT CONCAT(
        'INSERT INTO recipes (recipe_name) VALUES (''Recipe ', n, ''');\n',
        'INSERT INTO recipe_ingredients VALUES\n',
        '(LAST_INSERT_ID(),1,', FLOOR(RAND()*500)+100, '),\n',
        '(LAST_INSERT_ID(),2,', FLOOR(RAND()*300)+50, '),\n',
        '(LAST_INSERT_ID(),3,', FLOOR(RAND()*20)+2, '),\n',
        '(LAST_INSERT_ID(),4,', FLOOR(RAND()*400)+100, '),\n',
        '(LAST_INSERT_ID(),5,', FLOOR(RAND()*400)+100, '),\n',
        '(LAST_INSERT_ID(),6,', FLOOR(RAND()*80)+10, '),\n',
        '(LAST_INSERT_ID(),7,', FLOOR(RAND()*4)+1, '),\n',
        '(LAST_INSERT_ID(),8,', FLOOR(RAND()*200)+50, '),\n',
        '(LAST_INSERT_ID(),9,', FLOOR(RAND()*80)+10, '),\n',
        '(LAST_INSERT_ID(),10,', FLOOR(RAND()*15)+3, ');\n'
    ) AS full_block
    FROM (
        SELECT @row := @row + 1 AS n
        FROM information_schema.tables,
             (SELECT @row := 0) r
        LIMIT 1000
    ) numbers
) blocks;

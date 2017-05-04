module CreateTableTodos

using Genie, SearchLight

function up()
  SearchLight.query("""CREATE SEQUENCE todos__seq_id""")
  SearchLight.query("""
    CREATE TABLE IF NOT EXISTS todos (
      id            integer CONSTRAINT todos__idx_id PRIMARY KEY DEFAULT NEXTVAL('todos__seq_id'),
      title         varchar(500) NOT NULL,
      completed     boolean DEFAULT FALSE,
      created_at    timestamp,
      updated_at    timestamp DEFAULT current_timestamp
    )
  """)
  SearchLight.query("""ALTER SEQUENCE todos__seq_id OWNED BY todos.id""")
end

function down()
  SearchLight.query("DROP TABLE todos")
end

end

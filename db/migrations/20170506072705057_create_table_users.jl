module CreateTableUsers

using Genie, SearchLight

function up()
  SearchLight.query("CREATE SEQUENCE users__seq_id")
  SearchLight.query("
    CREATE TABLE IF NOT EXISTS users (
      id            integer CONSTRAINT users__idx_id PRIMARY KEY DEFAULT NEXTVAL('users__seq_id'),
      name          varchar(100) NOT NULL,
      email         varchar(100) NOT NULL,
      password      varchar(256) NOT NULL,
      role_id       integer DEFAULT NULL,
      CONSTRAINT users__idx_name UNIQUE(email)
    )
  ")
  SearchLight.query("ALTER SEQUENCE users__seq_id OWNED BY users.id")
  SearchLight.query("CREATE INDEX users__idx_role_id ON users (role_id)")
end

function down()
  SearchLight.query("DROP INDEX users__idx_role_id")
  SearchLight.query("DROP INDEX users__seq_id")
  SearchLight.query("DROP TABLE users")
end

end

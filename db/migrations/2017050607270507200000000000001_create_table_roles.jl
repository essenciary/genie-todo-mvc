module CreateTableRoles

using Genie, SearchLight

function up()
  SearchLight.query("CREATE SEQUENCE roles__seq_id")
  SearchLight.query("
    CREATE TABLE IF NOT EXISTS roles (
      id            integer CONSTRAINT roles__idx_id PRIMARY KEY DEFAULT NEXTVAL('roles__seq_id'),
      name          varchar(20) NOT NULL,
      CONSTRAINT    roles__idx_id UNIQUE(id),
      CONSTRAINT    roles__idx_name UNIQUE(name)
    )
  ")
  SearchLight.query("ALTER SEQUENCE roles__seq_id OWNED BY roles.id")
end

function down()
  SearchLight.query("DROP INDEX roles__seq_id")
  SearchLight.query("DROP TABLE roles")
end

end

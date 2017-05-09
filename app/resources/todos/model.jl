export Todo, Todos

using Channels

type Todo <: AbstractModel
  ### internals
  _table_name::String
  _id::String

  id::Nullable{SearchLight.DbId}
  title::String
  completed::Bool
  created_at::DateTime
  updated_at::DateTime

  validator::ModelValidator

  on_dehydration::Function
  on_hydration::Function

  after_save::Function

  scopes::Dict{Symbol,Vector{SearchLight.SQLWhereEntity}}

  ### constructor
  Todo(;
    id = Nullable{SearchLight.DbId}(),
    title = "",
    completed = false,
    created_at = Dates.now(),
    updated_at = Dates.now(),

    validator = ModelValidator([
      (:title, Validation.TodoValidator.not_empty)
    ]),

    on_dehydration = (m::Todo, field::Symbol, value::Any) -> begin
      if field == :updated_at
        Dates.now()
      end
    end,
    on_hydration = (m::Todo, field::Symbol, value::Any) -> begin
      if field == :updated_at

      end
    end,

    after_save = (m::Todo) -> begin
      Channels.broadcast("""{ "channel":"todos", "message":"update", "payload": { "todo": { "id": $(m.id |> Base.get) } } }""")
    end,

    scopes = Dict(:active => [SQLWhereExpression("completed = FALSE")])

  ) = new("todos", "id",
          id,
          title,
          completed,
          created_at,
          updated_at,

          validator,

          on_dehydration,
          on_hydration,

          after_save,

          scopes
          )
end

module Todos

using App, Faker

function random()
  todo = Todo()
  todo.title = Faker.sentence()

  todo
end

end

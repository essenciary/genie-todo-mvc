using Router

route("/", "todos#TodosController.index", named = :root)
route("/todos", "todos#TodosController.index", named = :todos)
route("/todos/:id::Int", "todos#TodosController.show", named = :todo_item)
route("/todos/:id::Int/edit", "todos#TodosController.edit")
route("/todos/:id::Int", "todos#TodosController.update", method = POST, named = :update_todo_item)
route("/todos/new", "todos#TodosController.new")
route("/todos", "todos#TodosController.create", method = POST, named = :create_todo_item)
route("/todos/:id::Int/delete", "todos#TodosController.delete", method = POST, named = :delete_todo_item)

# Authentication
route("/login", "user_sessions#UserSessionsController.show_login", named = :show_login)
route("/login", "user_sessions#UserSessionsController.login", method = POST, named = :login)
route("/logout", "user_sessions#UserSessionsController.logout", named = :logout)

route("/error") do
  error("foo!")
end

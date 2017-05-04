module TodosController

using App, JSON, Cookies, Sessions
@dependencies

# before_action = [Symbol("TodosController.say_hello")]

function index()
  todos = SearchLight.find(Todo, SQLQuery(scopes = [:active], order = "created_at DESC"))

  # cookie_val = Cookies.get(request(@params()), :foo)
  # val = (isnull(cookie_val) ? "" : Base.get(cookie_val)) * "*"
  # Logger.log(val, :debug)
  # Cookies.set!(response(@params()), :foo, val)
  #
  # session_val = Sessions.get(session(@params()), :bla)
  # sval = (isnull(session_val) ? "" : Base.get(session_val)) * "bla"
  # Logger.log(sval, :debug)
  # Sessions.set!(session(@params()), :bla, sval)

  has_requested(:json) ?
    respond_with_json(:todos, :index, todos = todos) :
    respond_with_html(:todos, :index, todos = todos)
end

function show()
  todo = SearchLight.find_one(Todo, @params(:id))
  has_requested(:json) ?
    respond_with_json(:todos, :show, check_nulls = [:todo => todo]) :
    respond_with_html(:todos, :show, check_nulls = [:todo => todo])
end

function edit(todo = Todo())
  todo = is_persisted(todo) ? todo : SearchLight.find_one(Todo, @params(:id))
  respond_with_html(:todos, :edit, check_nulls = [:todo => todo], params = @params)
end

function update()
  ntodo = SearchLight.find_one(Todo, @params(:id))
  if isnull(ntodo)
    return error_404()
  end

  todo = SearchLight.update_with!(Base.get(ntodo), @params(:todo))

  if Validation.validate!(todo) && SearchLight.save(todo)
    flash("Todo updated", @params)
    link_to!!(:todo_item, id = @params(:id)) |> redirect_to
  else
    flash("Todo has errors", @params)
    return edit(todo)
  end
end

function new(todo = Todo())
  respond_with_html(:todos, :new, todo = todo, params = @params)
end

function create()
  todo = SearchLight.create_with(Todo, @params(:todo))
  if Validation.validate!(todo)
    todo = SearchLight.save!!(todo)
    redirect_to(link_to(:todo_item, id = Base.get(todo.id)))
  else
    new(todo)
  end
end

function delete()
  ntodo = SearchLight.find_one(Todo, @params(:id))
  isnull(ntodo) && return error_404()
  SearchLight.delete(Base.get(ntodo))
  flash("Todo was deleted", @params)
  redirect_to(link_to(:todos))
end

function say_hello()
  println("Hello")
end

end

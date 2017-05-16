![Genie Logo](https://dl.dropboxusercontent.com/s/0dbiza50r63cvvc/genie_logo.png)

# Genie TodoMVC
### Demo app for Genie, the highly productive Julia web framework.

Genie is a full-stack MVC web framework that provides a streamlined and efficient workflow for developing modern web applications. It builds on top of Julia's (julialang.org) strengths (high-level, high-performance, dynamic, JIT compiled, functional programming language), adding a series of modules, methods and tools for promoting productive web development.

### How to run it?

First of all, make sure you have Julia and Genie on your machine. For help setting up Genie, check http://genieframework.com

Clone the app's repo and `cd` in it.
```
$> git clone https://github.com/essenciary/genie-todo-mvc
$> cd genie-todo-mvc
```

The app needs PostgreSQL - make sure you have it running on your machine.

Edit `config/database.yml` and setup your DB connection info (the `dev` DB info should enough). Make sure the DB exists, Genie won't create it.

Open a Genie REPL into the app
```
$> bin/repl
```

Generate a secrets file for signing and encrypting sensitive Genie data.
```julia
julia> Genie.REPL.write_secrets_file()
```

Ask Genie to setup its core DB tables.
```julia
julia> Genie.REPL.db_init()
```

Run the migrations to setup the app's DB tables.
```julia
julia> Migration.all_up()
```

Now you can generate some dummy test data to try things out.
```julia
julia> todo = Todos.random()
App.Todo
+============+=========================+
|        key |                   value |
+============+=========================+
|  completed |                   false |
+------------+-------------------------+
| created_at | 2017-05-16T13:23:58.623 |
+------------+-------------------------+
|         id |       Nullable{Int32}() |
+------------+-------------------------+
|      title |     Assumenda incidunt. |
+------------+-------------------------+
| updated_at | 2017-05-16T13:23:58.623 |
+------------+-------------------------+

julia> SearchLight.save!(todo)
App.Todo
+============+=========================+
|        key |                   value |
+============+=========================+
|  completed |                   false |
+------------+-------------------------+
| created_at | 2017-05-16T13:23:58.623 |
+------------+-------------------------+
|         id |     Nullable{Int32}(33) |
+------------+-------------------------+
|      title |     Assumenda incidunt. |
+------------+-------------------------+
| updated_at | 2017-05-16T13:24:04.578 |
+------------+-------------------------+
```

Or you can generate more test data at a time using Genie's `DatabaseSeeding` functionality.
```julia
julia> using DatabaseSeeding
julia> using TodosSeeds
julia> TodosSeeds.random() # will generate 10 random todos
```

Start the web server.
```
$> bin/server
```

Access the app on `http://localhost:8000`

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

Start the web server.
```julia
julia> AppServer.startup()
```

Access the app on `http://localhost:8000`

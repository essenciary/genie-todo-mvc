module TodosChannel

using Channels, App
@dependencies

function subscribe()
  Channels.subscribe(wsclient(@params), "/todos")
  "OK"
end

end

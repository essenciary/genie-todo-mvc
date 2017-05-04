using Router, Channels

channel("/todos/subscribe", "todos#TodosChannel.subscribe", named = :todos)

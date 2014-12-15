# TODO reminder
manage all your todos

`gem install todo_reminder`

example:

```
require 'todo_reminder'

t1 = Thread.new do
    TodoReminder.remind("contains_todos.rb", {:interval => 120}) do |todo|
        puts todo.to_json
    end
end

[t1].map(&:join)
``` 

Finds all TODO's in a file and outputs the TODO object as json

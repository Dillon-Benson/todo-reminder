# TODO reminder
manage all your todos

`gem install todo_reminder`

example:

```ruby
# contains_todos.rb
return "bigger" if 5 > 4 # TODO 5423: evaluate comparison before return
```

```ruby
require 'todo_reminder'

t1 = Thread.new do
    TodoReminder.remind("contains_todos.rb", {:interval => 120}) do |todo|
        puts todo.to_json
    end
end

[t1].map(&:join)
``` 

Finds all TODO's in a file and outputs the TODO object as json

## Operations on Todo object
`todo.line` returns the whole line where the TODO was found   
`todo.line_number` returns the line number of the TODO in the file   
`todo.code` returns the code part of the line   
`todo.comment` returns the whole comment including '#'   
`todo.id` returns the id of the TODO   
`todo.text` returns what the actual TODO is   
`todo.to_json` returns a JSON representation of the Todo object

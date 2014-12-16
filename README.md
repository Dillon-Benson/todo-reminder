# TODO reminder ![](https://travis-ci.org/Dillon-Benson/todo-reminder.svg?branch=master)
manage all your todos

`gem install todo_reminder`   

find all comments in a file containing TODO id:

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

## How it works
Given a file, If it contains any comments followed by "TODO" and a random integer ID, TODO reminder will yield that TODO if it exists after N seconds.   
Specify the interval in seconds like: ```{options[:interval] = 30}```

## Operations on Todo object
`todo.line` returns the whole line where the TODO was found   
`todo.line_number` returns the line number of the TODO in the file   
`todo.code` returns the code part of the line   
`todo.comment` returns the whole comment including '#'   
`todo.id` returns the id of the TODO   
`todo.text` returns what the actual TODO is   
`todo.to_json` returns a JSON representation of the Todo object

# Contributing
1. Fork project
2. Work on an issue or create new reminders in lib/todo_reminder/reminders. These are module methods that handle how to remind of the TODO's inside the remind block
3. Write meaningful tests and run them
4. Send pull request

# License
Copyright (c) 2014 Dillon Benson

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

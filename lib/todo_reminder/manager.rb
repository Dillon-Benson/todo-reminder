module TodoReminder
  class Manager
    def initialize(todos, options = {})
      @todos = todos
    end

    def [](id)
      @todos.each do |todo|
        return todo if todo.id == id
      end
    end

    def all_ids
      @todos.map(&:id)
    end
  end
end

module TodoReminder
  class Reminder
    def initialize(path, options = {})
      @options = options
      @interval = options[:interval]
      @path = path
    end

    def start
      while(true)
        # Get initial todos
        ids = refresh_todos

        # Sleep
        sleep(@interval)  # TODO 1232: fix sleep

        # Check for todos after sleeping
        new_ids = refresh_todos

        # Check each new_id
        new_ids.each do |id|
          if ids.include?(id)   # If that id also also exists in old_ids
            todo = @manager[id] # Get that todo
            if block_given?
              yield todo       # yield that todo if block given
            else
              raise BlockRequiredError, "#{self}.start needs a block"
            end
          end
        end
      end
    end

    private
    def refresh_todos
      todos = Scraper.todos(@path)
      @manager = Manager.new(todos, @options)
      @manager.all_ids
    end
  end
end

module TodoReminder
  module Reminders
    def self.say(todo)
      system("say To do #{todo.id} still exists.")
    end
  end
end

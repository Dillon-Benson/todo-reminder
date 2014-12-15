require 'todo_reminder/filehandler'
require 'todo_reminder/todo'
require 'todo_reminder/scraper'
require 'todo_reminder/manager'
require 'todo_reminder/reminder'

module TodoReminder
  class BlockRequiredError < StandardError
  end

  Comment = /#(\s*)TODO(\s*)?(\d+)(\s*)?:(.*)/
  Line = /(.*)?#{Comment}/
  OPTIONS = {
    :rewind => true,
    :interval => 10
  }

  def self.remind(path, options = {})
    trap "SIGINT" do
      exit 130
    end

    reminder = Reminder.new(path, OPTIONS.merge(options))
    raise BlockRequiredError, "Need a block." unless block_given?
    reminder.start { |todo| yield(todo) }
  end
end

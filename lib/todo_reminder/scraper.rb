module TodoReminder
  class Scraper
    def self.todos(path, options = {})
      fh = FileHandler.new(path, options)
      fh.all_matches_with_line_number(Line).map do |match|
        Todo.new(match[0].to_s, match[1], options)
      end
    end
  end
end

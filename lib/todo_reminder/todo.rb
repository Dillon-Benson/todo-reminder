module TodoReminder # TODO 3123: add attribute for file name of To do
  class Todo
    attr_reader :line, :line_number

    def initialize(line, line_number, options = {})
      @line = line
      @line_number = line_number
    end

    def code
      line.split("#")[0].lstrip.rstrip
    end

    def comment
      line.match(Comment).to_s
    end

    def id
      comment.match(/\d+/).to_s
    end

    def text
      comment.match(/:\s*/).post_match
    end

    def to_json
      "{\"text\": \"#{text}\", \"code\": \"#{code}\", \"line_number\": #{line_number}, \"comment\": \"#{comment}\", \"id\": \"#{id}\"}"
    end
  end
end

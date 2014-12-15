module TodoReminder
  class FileHandler
    include Enumerable

    attr_reader :path, :rewind_before
    attr_accessor :current_line

    def initialize(path, options = {})
      @options = options
      @rewind_before = options[:rewind]
      @path = path
      @current_line = 0
      @file = open_file(path)
    end

    # calls block for each line in file
    # used to mixin Enumerable
    def each(&block)
      @file.rewind if rewind_before
      @file.each_line do |line|
        block.call(line)
      end
    end

    # calls match at line_number with regex
    def match(line_number, regex)
      readline(line_number).match(regex)
    end

    # calls match a current_line with regex
    def next_match(regex)
      match(current_line, regex)
    end

    # matches all lines in @file with regex
    def all_matches(regex)
      matches = []
      self.each do |line|
        match = line.match(regex)
        matches << match unless match.nil?
      end
      matches
    end

    def all_matches_with_line_number(regex)
      matches = []
      self.each_with_index do |line, index|
        match = line.match(regex)
        matches << [match, index + 1] unless match.nil?
      end
      matches
    end

    # reads a file at line_number
    def readline(line_number)
      @file.rewind if rewind_before
      line = @file.readlines[line_number]
      yield line if block_given?
      line
    end

    # read a file at the current_line
    def nextline
      readline(current_line) do |line|
        @current_line += 1
        return line
      end
    end

    def close
      @file.close
    end

    def method_missing(method_name, *args, &block)
      if @file.methods.include?(method_name)
        return @file.send(method_name, *args)
      else
        super
      end
    end

    def open
      @file = open_file(filename) if @file.closed?
    end

    private
    def open_file(filename)
      begin
        File.open(filename)
      rescue Errno::ENOENT
        puts "File not found."
      rescue Exception
        puts "Can't open file."
      end
    end
  end
end

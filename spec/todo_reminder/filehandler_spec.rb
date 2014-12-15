require 'spec_helper'

describe FileHandler do
  before(:each) do
    path = File.dirname(__FILE__) + '/example'
    options = { :rewind => true }
    @fh = FileHandler.new(path, options)
  end

  describe "#intialize" do
    it "should take a path and options and return a FileHandler object" do
      @fh.should be_an_instance_of FileHandler
    end
  end

  describe "#each" do
    it "should take a block and call that block on each line" do
      ones = []
      @fh.each do |line|
        ones << "1" if line == "1\n"
      end
      ones.should == ["1", "1", "1"]
    end

    it "should also mixin the Enumerable methods" do
      line3 = "# hello #\n"
      found = false
      @fh.each_with_index do |line, index|
        found = true if index == 2 && line == line3
      end
      found.should == true
    end
  end

  describe "#match" do
    it "should return match data by matching a file line with a regex" do
      regex = /#/
      match = @fh.match(2, regex)
      match.post_match.lstrip.should == "hello #\n"
    end
  end

  describe "#next_match" do
    it "should return a match or nil if there was no match for the current line" do
      regex = /\w+/
      match = @fh.next_match(regex)
      match.to_s.should == "example"
    end
  end

  describe "#all_matches" do
    it "should return all lines in a file that match a regex" do
      regex = /\d/
      matches = @fh.all_matches(regex).map(&:to_s)
      matches.should == ["1", "1", "1", "1", "1", "2"]
    end
  end

  describe "#readline" do
    it "should return the contents of a file at a line (zero based)" do
      line = @fh.readline(1)
      line.should == "1 2 3 4\n"
    end
  end

  describe "#nextline" do
    it "should return the content of a file at the current line" do
      @fh.current_line = 2
      line = @fh.nextline
      line.should == "# hello #\n"
    end
  end

  describe "#closed?" do
    it "should return true if the file is closed through method_missing" do
      @fh.close
      @fh.closed?.should == true
    end
  end

  describe "#method_missing" do
    it "should not allow method that aren't defined in File" do
      expect { @fh.hello }.to raise_error(NoMethodError)
    end
  end
end

require 'spec_helper'

describe Todo do
  before(:each) do
    path = File.dirname(__FILE__) + '/example'
    options = { :rewind => true }
    @fh = FileHandler.new(path, options)
    line = @fh.readline(6)
    @todo = Todo.new(line, 7)
  end

  describe "#initialize" do
    it "should take a line of code with a TODO comment in it and return a Todo object" do
      @todo.should be_an_instance_of Todo
    end
  end

  describe "#code" do
    it "should return the code part of the line" do
      @todo.code.should == "r += 1"
    end
  end

  describe "#comment" do
    it "should return the comment including '#'" do
      @todo.comment.should == "# TODO 2133: fix me"
    end
  end

  describe "#id" do
    it "should return the id of the todo" do
      @todo.id.should == "2133"
    end
  end

  describe "#text" do
    it "should return the text part of the todo" do
      @todo.text.should == "fix me"
    end
  end

  describe "#line_number" do
    it "should return the line number of the todo" do
      @todo.line_number.should == 7
    end
  end

  describe "#to_json" do
    it "should return a json representation of the Todo" do
      exected = "{\"text\": \"fix me\", \"code\": \"r += 1 \", \"line_number\": 7, \"comment\": \"# TODO 2133: fix me\", \"id\": \"2133\"}"
    end
  end
end

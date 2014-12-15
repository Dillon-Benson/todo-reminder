require 'spec_helper'

describe Scraper do
  describe "#todos" do
    it "should return an array of Todo objects given a file" do
      path = File.dirname(__FILE__) + '/example'
      todos = Scraper.todos(path)
      todos.length.should == 2
    end
  end
end

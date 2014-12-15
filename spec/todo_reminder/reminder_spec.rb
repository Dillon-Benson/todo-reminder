require 'spec_helper'

describe Reminder do
  before(:each) do
    path = File.dirname(__FILE__) + '/reminder'
    options = {:interval => 3, :rewind => true}
    @reminder = Reminder.new(path, options)
  end

  describe "#start" do
    it "should show what Todos exist in a file" do
      ids = []
      t = Thread.new {
        begin
          @reminder.start { |todo| ids << todo.id }
        rescue Exception
        end
      }
      t.abort_on_exception = true
      sleep(4)
      t.raise(Exception)
      ids.should == ["142", "422"]
    end

    it "should raise a StandardError when not given a block" do
      expect { @reminder.start }.to raise_error(StandardError)
    end
  end
end

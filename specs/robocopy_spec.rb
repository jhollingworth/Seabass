require "spec"
require File.dirname(__FILE__) + '/../lib/albacore/deployment'
require File.dirname(__FILE__) + '/mocks/mock_env'

describe "When I copy a single file" do

  before(:all) do
    @executor = MockExecutor.new
    @command = Robocopy.new(MockEnv.new , @executor)
    @command.files << "c:/foo.zip"
    @command.destination = "c:/foo"
    @command.execute
  end

  it "should copy the file" do
    @executor.commands.length.should == 1
    @executor.commands[0].should include('robocopy c:/ c:/foo foo.zip')
  end
end

describe "When I copy multiple files" do
  before(:all) do
    @executor = MockExecutor.new
    @command = Robocopy.new(MockEnv.new, @executor)
    @command.files << "c:/foo.zip"
    @command.files << "c:/bar.zip"
    @command.destination = "c:/foo"
    @command.execute
  end

  it "should copy all the files" do
    @executor.commands.length.should == 2
    @executor.commands[0].should include 'robocopy c:/ c:/foo foo.zip'
    @executor.commands[1].should include 'robocopy c:/ c:/foo bar.zip'
  end
end

describe "When I copy a directory" do
  before(:all) do
    @executor = MockExecutor.new
    @command = Robocopy.new(MockEnv.new, @executor)
    @command.directories << "c:/bar"
    @command.destination = "c:/foo"
    @command.execute
  end

  it "should copy the directory" do
    @executor.commands.length.should == 1
    @executor.commands[0].should include 'robocopy c:/bar c:/foo /E'
  end
end

class MockExecutor
  attr_accessor :commands

  def initialize()
    @commands = []
  end
  def run(command)
    @commands << command
  end
end
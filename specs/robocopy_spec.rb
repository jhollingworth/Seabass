require "spec"
require File.dirname(__FILE__) + '/../lib/albacore/deployment'
require File.dirname(__FILE__) + '/mocks/mock_robocopy'

describe "When I do not specify a destination" do

  before(:all) do
    @command = MockRobocopy.new
    @command.destination = ""
  end

  it "should raise an exception" do
    lambda { @command.execute }.should raise_error
  end
end

describe "When I do not specify either files or directories" do

  before(:all) do
    @command = MockRobocopy.new
    @command.destination = "c:\foo"
  end

  it "should raise an exception" do
    lambda { @command.execute }.should raise_error
  end
end

describe "When I copy a single file" do

  before(:all) do
    @command = MockRobocopy.new
    @command.files << "c:/foo.zip"
    @command.destination = "c:/foo"
    @command.execute
  end

  it "should copy the file" do
    @command.executor.commands.length.should == 1
    @command.executor.commands[0].should include('robocopy c:/ c:/foo foo.zip')
  end
end

describe "When I copy multiple files" do
  before(:all) do
    @command = MockRobocopy.new
    @command.files << "c:/foo.zip"
    @command.files << "c:/bar.zip"
    @command.destination = "c:/foo"
    @command.execute
  end

  it "should copy all the files" do
    @command.executor.commands.length.should == 2
    @command.executor.commands[0].should include 'robocopy c:/ c:/foo foo.zip'
    @command.executor.commands[1].should include 'robocopy c:/ c:/foo bar.zip'
  end
end

describe "When I copy a directory" do
  before(:all) do
    @command = MockRobocopy.new
    @command.directories << "c:/bar"
    @command.destination = "c:/foo"
    @command.execute
  end

  it "should copy the directory" do
    @command.executor.commands.length.should == 1
    @command.executor.commands[0].should include 'robocopy c:/bar c:/foo /E'
  end
end

describe "when I want to mirror two folders" do
  before(:all) do
    @command = MockRobocopy.new
    @command.directories << "c:/bar"
    @command.destination = "c:/foo"
    @command.mirror = true
    @command.execute
  end

  it "should include the mirror switch" do
    @command.executor.commands[0].should include '/MIR'
  end
end

require File.dirname(__FILE__) + '/mock_env'
require File.dirname(__FILE__) + '/mock_executor'

class MockRobocopy < Robocopy

  attr_accessor :executor

  def initialize()
    @executor = MockExecutor.new
    super(MockEnv.new, @executor)
  end
end


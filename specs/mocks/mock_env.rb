class MockEnv

  attr_reader :tools

  def initialize()
    @tools = MockTools.new
  end

  class MockTools
    attr_reader :robocopy

    def initialize()
      @robocopy = 'robocopy'
    end
  end
end
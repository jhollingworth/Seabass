class MockExecutor
  attr_accessor :commands

  def initialize()
    @commands = []
  end
  def run(command)
    @commands << command
  end
end
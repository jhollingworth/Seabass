class Env
  attr_reader :tools
  
  def initialize(tools = Tools.new)
    @tools = tools
  end


  class Tools
    attr_accessor :robocopy
    def initialize()
      tools_dir = File.dirname(__FILE__) + '../tools/'
      @robocopy =  tools_dir + 'robocopy.exe'
    end
  end
end


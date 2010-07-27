
class Robocopy
  attr_accessor :files, :directories, :destination

  def initialize(env = @@env, executor = Executor.new)
    @env = env
    @files = []
    @directories = []
    @executor = executor
  end

  def execute()
    raise "No files or directories were specified" if @files.length == 0 and @directories.length == 0
    raise "Destination folder was not specified" if @destination.nil?

    copy = lambda { |type, collection|
      collection.each do |f|
        command = case type
          when 'file' then file_command(f, @destination)
          when 'directory' then directory_command(f, @destination)
          else raise "Unknown copy type"
        end
        Log.message("Copying #{f} #{destination}; #{command}", :info)
        @executor.run("#{@env.tools.robocopy} #{command}")
      end
    }

    copy.call('file', @files)
    copy.call('directory', @directories)
  end

  private

  def file_command(path, destination)
    "#{File.dirname(path)} #{destination} #{File.basename(path)}"
  end

  def directory_command(path, destination)
    "#{path} #{destination} /E"
  end
end

class Executor
  def run(command)
    %x[#{command}]
  end
end
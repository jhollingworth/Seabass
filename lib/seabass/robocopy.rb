require 'albacore/support/albacore_helper'

class Robocopy
  include RunCommand
  include YAMLConfig
  include Logging

  attr_accessor :files, :directories, :destination, :mirror

  def initialize(env = @@env, executor = Executor.new)
    @env = env
    @files = []
    @directories = []
    @executor = executor
    @mirror = false
  end

  def execute()
    raise "No files or directories were specified" if @files.length == 0 and @directories.length == 0
    raise "Destination folder was not specified" if @destination.nil?

    copy = lambda { |type, collection|
      collection.each do |f|
        command = "#{@env.tools.robocopy} " + case type
          when 'file' then file_command(f, @destination)
          when 'directory' then directory_command(f, @destination)
          else raise "Unknown copy type"
        end
        command += " /MIR" if @mirror 

        Log.message("Copying #{f} #{destination}; #{command}", :info)
        @executor.run(command)
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
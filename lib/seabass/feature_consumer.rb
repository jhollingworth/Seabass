require 'ftools'

class FeatureConsumer
  include RunCommand
  include YAMLConfig
  include Logging

  attr_accessor :package_dir, :consumer_dir, :application_name

  def execute()
    raise "The directory containing the packages has not been specified" if @package_dir.nil?
    raise "The directory packages should be copied to has not been specified" if @consumer_dir.nil?
    raise "The name of the application has not been specified" if @application_name.nil?

    Dir[@package_dir + "/#{@application_name}/**/**"].each do |resource|
      raise "Could not find the app name in the resource type" if resource.match(/.*\/#{@application_name}\/(.*)/).nil?
      
      destination = File.expand_path(File.join(@consumer_dir, $1))
      next if File.directory?(resource)

      dir = File.expand_path(File.dirname(destination))
      FileUtils.mkdir_p(dir) if false == File.exists?(dir)

      puts "Copying #{resource} to #{destination}"
      File.copy(resource, destination)
    end
  end
end
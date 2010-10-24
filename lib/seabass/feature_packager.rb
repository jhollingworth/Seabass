require 'ftools'
require 'yaml'

class FeaturePackager
  include RunCommand
  include YAMLConfig
  include Logging

  attr_accessor :source_dir, :package_dir, :valid_file_types

  def initialize()
    @valid_file_types = ['aspx', 'ascx', 'js', 'css', 'png', 'gif', 'jpeg', 'dll']
  end

  def execute()
    raise "Please specify the directory where the features to package exist" if @source_dir.nil?
    raise "Please specify the directory packages should be placed into" if @package_dir.nil?

    Dir[@source_dir + '/**/feature.yml'].each do |feature|
      next if File.basename(File.dirname(feature)).downcase == File.basename(@source_dir).downcase

      feature_config = YAML.load(File.read(feature))
	  
      raise "The feature config does not contain the feature name" if !feature_config.has_key?('name')
      raise "The feature config does not contain the destination name" if !feature_config.has_key?('destination_name')
	  
      destination = File.expand_path(File.join(@package_dir, feature_config['name'], feature_config['destination_name']))
      FileUtils.mkdir_p(destination)

      feature_root = File.expand_path(File.dirname(feature) + '/../')

      Dir[feature_root  + '/**/**'].each do |file|
        next if File.directory?(file)
        next if is_not_valid_file_type(file)
        file_destination = File.join(destination, file.gsub(/#{feature_root}/, ''))
        FileUtils.mkdir_p(File.dirname(file_destination)) if(!File.exists?(File.dirname(file_destination)))
        File.copy(file, file_destination)
      end
    end
  end

  private

  def is_not_valid_file_type(file)
    @valid_file_types.each do |v|
      return false if !file.match(/\.#{v}$/).nil?
    end
    return true
  end
end
require 'rubygems'
require 'rubygems/gem_runner'
require 'rubygems/exceptions'

required_version = Gem::Requirement.new "> 1.8.5"

unless required_version.satisfied_by? Gem.ruby_version then
  abort "Expected Ruby Version #{required_version}, was #{Gem.ruby_version}"
end

def install(lib)
  begin
    matches = Gem.source_index.find_name(lib)
    if matches.empty?
      puts "Installing #{lib}"
      Gem::GemRunner.new.run ['install', lib]
    else
      puts "Found #{lib} gem - skipping"
    end
  rescue Gem::SystemExitException => e
  end
end

puts "Installing required dependencies"
install 'rake'
install 'albacore'
install 'jeweler'
install 'rspec'

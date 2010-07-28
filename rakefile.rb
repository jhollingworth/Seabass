require 'lib/seabass'

namespace :specs do
  require 'spec/rake/spectask'

  @spec_opts = '--colour --format specdoc'

  desc "Run functional specs for Albacore"
  Spec::Rake::SpecTask.new :all do |t|
    t.spec_files = FileList['specs/*_spec.rb']
    t.spec_opts << @spec_opts
  end
end

namespace :example do
  require 'rubygems'

  robocopy do |r|
      r.files << "foo.txt"
      r.files << "bar.txt"
      r.directories << "baz"
      r.destination = "foo"
  end
end

namespace :jeweler do
  begin
    require 'jeweler'
    Jeweler::Tasks.new do |gs|
      gs.name = "seabass"
      gs.summary = "Seabass-Safe Rake Tasks For The Deployment Of .NET Systems"
      gs.description = "Easily deploy your .NET solutions with Ruby and Rake, using this suite of Rake tasks."
      gs.email = "jamiehollingworth@gmail.com"
      gs.homepage = "http://github.com/jhollingworth/seabass"
      gs.authors = ["James Hollingworth"]
      gs.has_rdoc = false
      gs.files.exclude("seabass.gemspec", ".gitignore")
      gs.add_dependency('rake', '>= 0.8.7')
      gs.add_dependency('albacore', '>= 0.1.5')
      gs.add_development_dependency('rspec', '>= 1.2.8')
      gs.add_development_dependency('jeweler', '>= 1.2.1')
    end
    Jeweler::GemcutterTasks.new
  rescue LoadError
    puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
  end    
end

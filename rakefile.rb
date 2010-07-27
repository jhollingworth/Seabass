require 'lib/albacore/deployment'

namespace :specs do
  require 'spec/rake/spectask'

  @spec_opts = '--colour --format specdoc'

  desc "Run functional specs for Albacore"
  Spec::Rake::SpecTask.new :all do |t|
    t.spec_files = FileList['specs/*_spec.rb']
    t.spec_opts << @spec_opts
  end
end

namespace :jeweler do
  begin
    require 'jeweler'
    Jeweler::Tasks.new do |gs|
      gs.name = "albacore-deployment"
      gs.summary = "Dolphin-Safe Rake Tasks For The Deployment Of .NET Systems"
      gs.description = "Easily deploy your .NET solutions with Ruby and Rake, using this suite of Rake tasks."
      gs.email = "jamiehollingworth@gmail.com"
      gs.homepage = "http://github.com/jhollingworth/Albacore.Deployment"
      gs.authors = ["James Hollingworth"]
      gs.has_rdoc = false
      gs.files.exclude("albacore-deployment.gemspec", ".gitignore")
      gs.add_dependency('rake', '>= 0.1.5')
      gs.add_development_dependency('rspec', '>= 1.2.8')
      gs.add_development_dependency('jeweler', '>= 1.2.1')
    end
  rescue LoadError
    puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
  end    
end

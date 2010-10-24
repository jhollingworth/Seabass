create_task :robocopy, Proc.new { FeaturePackage.new } do |r|
  r.execute
end

create_task :robocopy, Proc.new { FeatureConsumer.new } do |r|
  r.execute
end

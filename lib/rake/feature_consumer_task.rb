create_task :consume_package, Proc.new { FeatureConsumer.new } do |r|
  r.execute
end

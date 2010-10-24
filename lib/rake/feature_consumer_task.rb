create_task :consume_features, Proc.new { FeatureConsumer.new } do |r|
  r.execute
end

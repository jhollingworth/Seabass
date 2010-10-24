create_task :package_feature, Proc.new { FeaturePackager.new } do |r|
  r.execute
end

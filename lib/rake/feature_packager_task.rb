create_task :package_feature, Proc.new { FeaturePackage.new } do |r|
  r.execute
end

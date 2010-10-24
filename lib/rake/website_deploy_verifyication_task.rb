create_task :website_deploy_verification, Proc.new { WebsiteDeployVerifier.new } do |r|
  r.execute
end

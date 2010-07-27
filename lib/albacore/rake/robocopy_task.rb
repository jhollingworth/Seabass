create_task :robocopy, Proc.new { Robocopy.new } do |r|
  r.execute
end

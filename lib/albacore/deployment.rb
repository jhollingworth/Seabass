$: << File.expand_path(File.dirname(__FILE__))
$: << File.expand_path(File.join(File.dirname(__FILE__), "deployment"))
$: << File.expand_path(File.join(File.dirname(__FILE__), "rake"))


require 'albacore'

include_files = lambda { |p|
  Dir.glob(File.join(File.expand_path(File.dirname(__FILE__)), p)).each {|f| require f }
}

include_files.call('deployment/*.rb')
include_files.call('rake/*.rb')
@@env = Env.new

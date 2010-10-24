require 'rubygems'
require 'spec'
require 'mocha'
require File.dirname(__FILE__) + '/../lib/seabass'

Dir.glob(File.join(File.expand_path(File.dirname(__FILE__)), 'mocks/*.rb')).each {|f| require f }

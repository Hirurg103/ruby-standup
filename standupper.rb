require 'bundler'
Bundler.require(:default)

require 'active_support/all'

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'standup'
require 'standup_message'

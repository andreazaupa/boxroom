$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'

load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user  # Don't use system-wide RVM
load 'deploy/assets'

load 'config/deploy' # remove this line to skip loading any of the default tasks
require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'auth-deploy/capistrano'

set :application, "boxroom"

set :stages, %w(staging production)
set :default_stage, "staging"

set :scm, "git"
set :repository,  "git@github.com:andreazaupa/boxroom.git"
set :deploy_via, :remote_cache
set :scm_verbose, true
set :branch, "master"


set :deploy_to, "/space/apache/htdocs/#{application}"


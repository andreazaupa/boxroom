# set :application, "boxroom"
# set :repository,  "git@github.com:andreazaupa/boxroom.git"
# 
# set :scm, :git
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# 
# role :web, "jupiter.azaupa.info"                          # Your HTTP server, Apache/etc
# role :app, "jupiter.azaupa.info"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# 
# 
# # if you're still using the script/reaper helper you will need
# # these http://github.com/rails/irs_process_scripts
# 
# # If you are using Passenger mod_rails uncomment this:
# # namespace :deploy do
# #   task :start do ; end
# #   task :stop do ; end
# #   task :restart, :roles => :app, :except => { :no_release => true } do
# #     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
# #   end
# # end
# Deploy Config
# =============
#
# Copy this file to config/deploy.rb and customize it as needed.
# Then run `cap deploy:setup` to set up your server and finally
# `cap deploy` whenever you would like to deploy Errbit. Refer
# to the Readme for more information.


require 'bundler/capistrano' # Run automatically bundle:install after deploy:update_code
# require "capistrano/ext/multistage"
# set :whenever_environment, defer { stage }
# require "whenever/capistrano"
server "jupiter.azaupa.info", :app, :web, :db, :primary => true

set :application, "boxroom"
set :repository,  "git@github.com:andreazaupa/boxroom.git"
set :rails_env, "production"
set :branch, "master"
set :deploy_to, "/home/web/apps/production/#{application}"
set :port, 2222
set :user, :web
set :use_sudo, false
set :ssh_options,      { :forward_agent => true }
default_run_options[:pty] = true

set :deploy_to, "/home/web/apps/production/#{application}"
set :deploy_via, :remote_cache
set :copy_cache, true
set :copy_exclude, [".git"]
set :copy_compression, :bz2

set :scm, :git
set :scm_verbose, true
set(:current_branch) { `git branch`.match(/\* (\S+)\s/m)[1] || raise("Couldn't determine current branch") }
set :branch, defer { current_branch }


desc "Update remote database file with local copy"


before "deploy:update_code", "deploy:update_database_config"
namespace :deploy do
task :update_database_config do
   run_locally("rsync --times --rsh=ssh --compress --human-readable --progress config/database.yml #{user}@#{domain}:#{shared_path}/config/database.yml")
   run("ln -nfs #{shared_configs}/database.yml #{release_configs}/database.yml")
   run("ln -nfs #{shared_configs}/production.sqlite #{release_configs}/../db/production.sqlite")
end
end
# after 'deploy:update_code', 'errbit:symlink_configs'

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# namespace :errbit do
#   task :setup_configs do
#     shared_configs = File.join(shared_path,'config')
#     run "mkdir -p #{shared_configs}"
#     run "if [ ! -f #{shared_configs}/config.yml ]; then cp #{latest_release}/config/config.example.yml #{shared_configs}/config.yml; fi"
#     run "if [ ! -f #{shared_configs}/mongoid.yml ]; then cp #{latest_release}/config/mongoid.example.yml #{shared_configs}/mongoid.yml; fi"
#   end
# 
#   task :symlink_configs do
#     errbit.setup_configs
#     shared_configs = File.join(shared_path,'config')
#     release_configs = File.join(release_path,'config')
#     run("ln -nfs #{shared_configs}/config.yml #{release_configs}/config.yml")
#     run("ln -nfs #{shared_configs}/mongoid.yml #{release_configs}/mongoid.yml")
#   end
# end
# 
# namespace :db do
#   desc "Create the indexes defined on your mongoid models"
#   task :create_mongoid_indexes do
#     run "cd #{current_path} && bundle exec rake db:mongoid:create_indexes"
#   end
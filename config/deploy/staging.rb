puts '*** Deploying to: STAGING environment ***'
server "192.168.254.95", :app, :web, :db, :primary => true
set :rails_env, "staging"

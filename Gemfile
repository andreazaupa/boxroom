source 'http://rubygems.org'

gem 'rake'
gem 'rails', '3.1.3'
gem 'jquery-rails'
gem 'sqlite3'
gem 'dynamic_form'
gem 'acts_as_tree'
gem 'paperclip'
gem "capistrano", :group=>:development

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.1.1'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier'
end

group :production do
  gem 'execjs'
  gem 'therubyracer'
end

group :development do
	gem 'auth-deploy', :git => "git://github.com/develonlab/auth-deploy.git"
end


group :test do
  gem 'factory_girl_rails'
end

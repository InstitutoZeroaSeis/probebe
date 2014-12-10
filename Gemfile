source 'http://production.cf.rubygems.org/'

gem 'rails', '4.1.6'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'pry'
gem 'rails-i18n', '~> 4.0.0'
gem 'carnival', :github => 'cartolari/carnival', :branch => 'master'
gem 'carnival_devise_views', :github => 'Vizir/carnival_devise_views', :branch => 'master'
gem 'devise', '~> 3.4.0'
gem 'devise-i18n', '~> 0.11.2'
gem 'omniauth-facebook', '~> 2.0.0'
gem 'omniauth-google-oauth2', '~> 0.2.5'
gem 'paperclip', '~> 4.2.0'
gem 'pretender', '~> 0.1.0'
gem 'simple_form', '~> 3.1.0.rc2'
gem 'jquery-ui-rails', '~> 5.0.2'
gem 'unicorn'
gem 'capistrano-rails', '~> 1.1.0'
gem 'rvm1-capistrano3', require: false
gem 'capistrano-bundler'
gem 'ckeditor', '~> 4.1.0'
gem 'cancancan', '~> 1.9.2'
gem 'savon', '~> 2.8.0'
gem 'paper_trail', '~> 3.0.6'
gem 'rack-cors', '~> 0.2.9'
gem 'rpush', '~> 2.2.0'

group :development do
  gem 'better_errors', '0.9.0'
  gem 'turbo_dev_assets', '~> 0.0.2'
  gem 'bullet'
  gem 'puma'
end

group :test do
  gem 'poltergeist', require: false
  gem 'database_cleaner', '~> 1.3.0'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'byebug', '~> 3.4.0'
  gem 'factory_girl', '~> 4.5.0', require: false
  gem 'pry-byebug', '~> 2.0.0'
  gem 'rspec', '~> 3.1.0'
  gem 'rspec-rails', '~> 3.1.0'
  gem "spring-commands-rspec", group: :development
  gem 'guard-rspec', require: false
  gem 'formulaic'
end

group :production do
  gem "non-stupid-digest-assets"
end

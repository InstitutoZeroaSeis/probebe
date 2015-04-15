source 'http://rubygems.org/'

gem 'rails', '4.1.6'
gem 'mysql2'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'spring',        group: :development
gem 'pry'
gem 'rails-i18n', '~> 4.0.0'
gem 'carnival', github: 'cartolari/carnival', branch: 'bug_fixes'
gem 'carnival_devise_views', '~> 0.0.4'
gem 'devise', '~> 3.4.0'
gem 'devise-i18n', '~> 0.11.2'
gem 'omniauth-facebook', '~> 2.0.0'
gem 'omniauth-google-oauth2', '~> 0.2.5'
gem 'paperclip', '~> 4.2.0'
gem 'pretender', '~> 0.1.0'
gem 'simple_form', '~> 3.1.0.rc2'
gem 'jquery-ui-rails', '~> 5.0.2'
gem 'ckeditor', '~> 4.1.0'
gem 'cancancan', '~> 1.9.2'
gem 'savon', '~> 2.8.0'
gem 'paper_trail', '~> 3.0.6'
gem 'rack-cors', '~> 0.2.9'
gem 'rpush', '~> 2.2.0'
gem 'active_model_serializers', '~> 0.9.1'
gem 'sidekiq', '~> 3.3.0'
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'puma'
gem 'whenever', '~> 0.9.4'
gem 'json', '1.8.1'
gem "fog", "~>1.20", require: "fog/aws/storage"
gem 'asset_sync', '~> 1.1.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-angular', '~> 1.3.15'
  gem 'rails-assets-angular-resource', '~> 1.3.15'
  gem 'rails-assets-moment', '~> 2.10.2'
end

group :development do
  gem 'better_errors', '0.9.0'
  gem 'turbo_dev_assets', '~> 0.0.2'
  gem 'bullet'
end

group :test do
  gem 'simplecov', require: false
  gem 'rspec-its', '~> 1.1.0'
end

group :development, :test do
  gem 'capybara-webkit'
  gem 'teaspoon'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'factory_girl', '~> 4.5.0', require: false
  gem 'pry-byebug', '~> 2.0.0'
  gem 'rspec', '~> 3.1.0'
  gem 'rspec-rails', '~> 3.1.0'
  gem "spring-commands-rspec", group: :development
  gem 'guard-rspec', require: false
end

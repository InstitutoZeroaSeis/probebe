ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

require 'factory_girl'
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'vendor/'
  add_filter 'spec/matchers/cancan_custom_matchers.rb'

  add_group 'Inputs', 'app/inputs/'
  add_group 'Presenters', 'app/presenters'
  add_group 'Value Objects', 'app/value_objects/'
  add_group 'View Objects', 'app/view_objects/'
  add_group 'Workers', 'app/workers/'
  add_group 'Serializers', 'app/serializers/'
end
# Requires all files with ActiveSupport require_dependency, so we can
# have 100% coverage and the Rails autoload feature will still works
Dir[Rails.root.join('app/**/*.rb')].each { |f| require_dependency f }
Dir[Rails.root.join('lib/**/*.rb')].each { |f| require_dependency f }

Capybara.javascript_driver = :selenium

Dir[Rails.root.join('spec/factories/**/*.rb')].each { |factory| require factory }
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/stubs/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/models/shared/**/*.rb')].each { |f| require f }

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
silence_stream(STDOUT) { load "#{Rails.root.join('db/schema.rb')}" }

Devise.stretches = 1
# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
  config.include Features::AuthenticationHelper, type: :feature
  config.include Features::RegexHelper, type: :feature
  config.include Features::TimelineHelper, type: :feature
  config.include Devise::TestHelpers, type: :controller
  config.include Controllers::ApiAuthenticationHelper, type: :controller
  config.include Controllers::AuthenticationHelper, type: :controller
  config.include Warden::Test::Helpers, type: :feature

  config.before(:each, :feature) do
    Warden.test_mode!
  end

  config.before(:each, :feature, :skip_auth) do
    Warden.test_reset!
  end

  config.after(:each, type: :feature) do
    Warden.test_reset!
  end
end

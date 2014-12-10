require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProBebe
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.autoload_paths << Rails.root.join('app/inputs')
    config.autoload_paths << Rails.root.join('app/models/ckeditor')
    config.autoload_paths << Rails.root.join('app/route_constraints/')
    config.autoload_paths << Rails.root.join('app/value_objects')
    config.autoload_paths << Rails.root.join('lib/')
    require Rails.root.join('lib/extensions/string')

    config.i18n.available_locales = :pt, :'pt-BR', :en
    config.i18n.default_locale = 'pt-BR'

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    console do
      require 'pry'
      config.console = Pry
    end

    # Application custom options
    config.message_delivery = ActiveSupport::OrderedOptions.new
    config.message_delivery.deliver_sms = false
  end
end

require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'pry'
require_relative '../lib/extensions/string'

Bundler.require(*Rails.groups)

module ProBebe
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('app/inputs')
    config.autoload_paths << Rails.root.join('app/models/ckeditor')
    config.autoload_paths << Rails.root.join('app/value_objects')
    config.autoload_paths << Rails.root.join('lib/')
    config.i18n.available_locales = :pt, :'pt-BR', :en
    config.i18n.default_locale = 'pt-BR'
    console { config.console = Pry }

    # Application custom options
    config.message_delivery = ActiveSupport::OrderedOptions.new
    config.message_delivery.deliver_sms = false
  end
end

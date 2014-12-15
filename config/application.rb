require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'pry'
require_relative '../lib/extensions/string'

Bundler.require(*Rails.groups)

module ProBebe
  class Application < Rails::Application
    config.autoload_paths += %W{#{config.root}/app}
    config.autoload_paths += %W{#{config.root}/lib}
    config.i18n.available_locales = :pt, :'pt-BR', :en
    config.i18n.default_locale = 'pt-BR'
    console { config.console = Pry }

    # Application custom options
    config.message_delivery = ActiveSupport::OrderedOptions.new
    config.message_delivery.deliver_sms = false
  end
end

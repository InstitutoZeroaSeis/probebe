require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'pry'
require_relative '../lib/extensions/string'

Bundler.require(*Rails.groups)

module ProBebe
  class Application < Rails::Application
    config.autoload_paths += %W{#{config.root}/app}
    config.autoload_paths += %W{#{config.root}/lib}
    config.autoload_paths += %W{#{config.root}/view_objects}
    config.autoload_paths += %W{#{config.root}/decorators}
    config.i18n.available_locales = :pt, :'pt-BR', :en
    config.i18n.default_locale = 'pt-BR'
    config.initialize_on_precompile = false

    config.exceptions_app = self.routes
    config.action_dispatch.rescue_responses['ActionController::RoutingError'] = :not_found

    console { config.console = Pry }
  end
end

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local       = false

  config.action_controller.perform_caching = true

  config.serve_static_assets = false
  config.assets.js_compressor = :uglifier
  config.assets.compile = true
  config.assets.digest = true
  config.assets.enabled = true
  config.assets.debug = false
  config.assets.version = '1.0'

  config.force_ssl = false

  config.active_support.deprecation = :notify
  config.log_level = :debug
  config.log_formatter = ::Logger::Formatter.new

  config.action_mailer.delivery_method = :file

  config.i18n.fallbacks = true

  config.active_record.dump_schema_after_migration = false

  Rails.application.routes.default_url_options[:host] = 'staging.probebe.org.br'
end

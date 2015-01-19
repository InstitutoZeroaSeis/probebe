# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( carnival_devise_views.css )
Rails.application.config.assets.precompile += %w( message_deliveries.js )
Rails.application.config.assets.precompile += %w( site_users.js )
Rails.application.config.assets.precompile += %w( inputs/countable_input.js )
Rails.application.config.assets.precompile += %w( inputs/week_to_date_input.js )
Rails.application.config.assets.precompile += %w( message_deliveries.js )
Rails.application.config.assets.precompile += %w( jquery-ui.css )
Rails.application.config.assets.precompile += %w( jquery-ui/datepicker-pt-BR.js )

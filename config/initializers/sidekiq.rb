Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_PROVIDER'] || 'redis://redis:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_PROVIDER'] || 'redis://redis:6379' }
end

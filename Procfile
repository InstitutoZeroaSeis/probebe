web:    bundle exec puma -e production -t 16:16 -p 80 --preload
worker: bundle exec sidekiq -C config/sidekiq.yml -e production
cron:   cron -f

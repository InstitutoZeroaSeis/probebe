#!/bin/bash

set -e

echo "Compiling assets..."
docker run -ti -e "RAILS_ENV=production" -e "BUNDLE_APP_CONFIG=/app/.bundle" -v $PWD:/app -w /app rails:4.1.6 bundle exec rake assets:precompile
echo "Finished assets compilation"

echo "Adding assets to git"
git add -A public/assets
git commit -m "EBS deploy"

echo "Deploying to Elastic Beanstalk"
eb deploy || true

echo "Reseting your git repo"
docker-compose run -ti web "rm -rf public/assets" && git reset --hard HEAD~1

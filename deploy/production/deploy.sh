#!/bin/bash

set -e

APP_NAME='probebe-docker'
APP_VERSION=production-$(git rev-parse --short HEAD)
APP_VERSION_DESCRIPTION=$(git log -1 --pretty=%B)
S3_BUCKET='elasticbeanstalk-us-east-1-505000041159'

echo "Building Docker Image..."
docker build -t vizir/probebe -f docker/web_production/Dockerfile .
echo "Pushing Docker Image..."
docker push vizir/probebe

echo "Uploading to S3"
aws s3 cp Dockerrun.aws.json s3://"$S3_BUCKET"/Dockerrun.aws.json

echo "Registrating uploaded file as a Beanstalk version"
aws elasticbeanstalk create-application-version --application-name $APP_NAME \
  --description "$APP_VERSION_DESCRIPTION" \
  --version-label "$APP_VERSION" \
  --source-bundle "S3Bucket=$S3_BUCKET,S3Key=Dockerrun.aws.json"

echo "Deploy to Beanstalk"
aws elasticbeanstalk update-environment \
  --environment-name production-docker \
  --version-label "$APP_VERSION"

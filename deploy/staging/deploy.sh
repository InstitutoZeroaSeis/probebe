#!/bin/bash

set -e

APP_NAME='probebe-docker'
APP_VERSION=staging-$(git rev-parse --short HEAD)
APP_VERSION_DESCRIPTION=$(git log -1 --pretty=%B)
S3_BUCKET='elasticbeanstalk-us-east-1-505000041159'
FILE_NAME=deploy-${APP_VERSION}.zip


echo "Building Docker Image..."
docker build -t vizir/probebe:staging -f docker/web_staging/Dockerfile .
echo "Pushing Docker Image..."
docker push vizir/probebe:staging

echo "Creating deploy bundle"
[[ -f tmp/deploy.zip ]] && rm -f tmp/deploy.zip
zip tmp/deploy.zip .ebextensions/* Dockerrun.staging.aws.json
printf "@ Dockerrun.staging.aws.json\n@=Dockerrun.aws.json\n" | zipnote -w tmp/deploy.zip

echo "Uploading to S3"
aws s3 cp tmp/deploy.zip s3://"$S3_BUCKET"/"$FILE_NAME"

echo "Registrating uploaded file as a Beanstalk version"
aws elasticbeanstalk create-application-version --application-name $APP_NAME \
  --description "$APP_VERSION_DESCRIPTION" \
  --version-label "$APP_VERSION" \
  --source-bundle "S3Bucket=$S3_BUCKET,S3Key=$FILE_NAME"

echo "Deploy to Beanstalk"
aws elasticbeanstalk update-environment \
  --environment-name staging \
  --version-label "$APP_VERSION"

#!/bin/sh

docker push vizir/probebe:staging
eb use staging
eb deploy

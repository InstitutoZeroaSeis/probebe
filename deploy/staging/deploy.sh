#!/bin/sh

docker push vizir/probebe:staging
eb deploy

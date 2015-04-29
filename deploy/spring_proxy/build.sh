#!/bin/sh
docker build -t vizir/probebe_spring_proxy -f docker/spring_proxy/Dockerfile .
docker push vizir/probebe_spring_proxy

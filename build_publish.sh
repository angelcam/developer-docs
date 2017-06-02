#!/usr/bin/env bash

tag=angelcam/developer-docs

docker build -t $tag .
docker push $tag
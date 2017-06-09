#!/bin/sh

set -e

docker pull angelcam/developer-docs:latest

docker stop developer-docs >/dev/null 2>&1 || /bin/true
docker rm -f developer-docs >/dev/null 2>&1 || /bin/true
docker run --restart=always -d \
    -e VIRTUAL_HOST={{ virtual_host }} \
    -e CERT_NAME={{ cert_name }} \
    --name developer-docs \
    --memory="500m" \
    angelcam/developer-docs:latest

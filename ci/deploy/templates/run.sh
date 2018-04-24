#!/bin/sh

set -e

docker pull angelcam/developer-docs:{{ tag }}

docker stop developer-docs >/dev/null 2>&1 || /bin/true
docker rm -f developer-docs >/dev/null 2>&1 || /bin/true
docker run --restart=always -d \
    -e VIRTUAL_HOST={{ virtual_host }} \
    -e LETSENCRYPT_HOST={{ virtual_host }} \
    -e LETSENCRYPT_EMAIL=devops@angelcam.com \
    --name developer-docs \
    --memory="500m" \
    angelcam/developer-docs:{{ tag }}

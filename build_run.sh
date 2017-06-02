#!/usr/bin/env bash

pwd=$(pwd -P)
src=dapperdox_src

. build.sh && \
docker run --rm \
    --name yaml_to_json.py \
    -v $pwd/$src:/dapperdox \
    $tag \
    yaml_to_json.py /dapperdox/specs \ &&
docker run --rm \
    --name developer-docs \
    -p 3123:3123 \
    -v $pwd/$src:/dapperdox \
    $tag
#!/usr/bin/env bash

pwd=$(pwd -P)

. build.sh && \
docker run --rm \
    --name developer-docs \
    -p 3123:3123 \
    -v $pwd/dapperdox_src:/dapperdox \
    $tag
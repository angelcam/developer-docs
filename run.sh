#!/usr/bin/env bash

IMAGE=angelcam/developer-docs
SRC=dapperdox_src

docker run --rm \
    --name yaml_to_json.py \
    -v $PWD/$SRC:/dapperdox \
    $IMAGE \
    yaml_to_json.py /dapperdox/specs \ &&
docker run --rm \
    --name developer-docs \
    -p 3123:3123 \
    -v $PWD/$SRC:/dapperdox \
    $IMAGE
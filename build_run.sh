#!/usr/bin/env bash

. ./build.sh && docker run --rm --name developer-docs -p 3123:3123 $tag
#!/usr/bin/env bash
image_name=herreraluis/basic_example:0.0.3
echo $image_name
docker build --tag $image_name -f Dockerfile .
docker images
docker run -ti --rm -p 5000:5000 $image_name
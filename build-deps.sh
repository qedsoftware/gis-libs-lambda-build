#!/bin/sh
#
#  Build LibGeos Dependencies. This script wraps the full build, including docker container
#  build and zip file creation.
#
docker build -t amzn-linux-libgeos .
docker run -v `pwd`:/output amzn-linux-libgeos
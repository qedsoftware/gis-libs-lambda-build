#!/bin/bash
#
#  Entrypoint script for creating a zip file that put the libraries in the
#  correct path structure for AWS Lambda

cd /opt
zip -r libgeos-amzn-linux.zip *
mv libgeos-amzn-linux.zip /output

#!/bin/bash
./rebuild.sh
docker build
docker push cbr_to_epub rdardour/ cbr_to_epub

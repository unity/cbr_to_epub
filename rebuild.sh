#!/bin/bash
docker kill cbr_to_epub;
docker rm cbr_to_epub;
docker build --tag=cbr_to_epub .;
docker run -d --name cbr_to_epub -v /tmp:/input -v /tmp:/output cbr_to_epub;

#!/bin/bash
docker kill cbr_to_epub;
docker rm cbr_to_epub;
docker build --tag=cbr_to_epub .;
docker run -d --name cbr_to_epub -v  /mnt/nas/Media/Books/Input:/input -v  /mnt/nas/Media/Books/Comics:/output -v  /mnt/nas/Media/Books/Done:/done cbr_to_epub;

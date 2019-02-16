#!/bin/bash

echo "Starting";
bundle exec /app/cbr --watch=$1 --output=$2 --done=$3

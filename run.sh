#!/bin/sh

image=delayed_job_test

docker build -t "$image" .
# docker run --rm -it -v $(pwd)/project:/usr/src/project -p 3000:3000 delayed_job_test "$@"

docker run --rm -it  -v $(pwd)/project:/mnt -p 3000:3000 "$image" "$@"

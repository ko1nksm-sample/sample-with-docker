#!/bin/sh

image=delayed_job_test
workdir=$(docker inspect -f "{{ .Config.WorkingDir  }}" $image)
docker run --rm -v $(pwd)/project:/mnt $image diff -u -r "$workdir" /mnt

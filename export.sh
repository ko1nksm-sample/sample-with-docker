!/bin/sh

image=delayed_job_test

workdir=$(docker inspect -f "{{ .Config.WorkingDir  }}" $image)
id=$(docker create $image)
docker cp $id:$workdir .
docker rm -v $id


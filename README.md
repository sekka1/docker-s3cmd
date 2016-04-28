docker-s3cmd
============

s3cmd in a Docker container.  This is useful if you are already using Docker.
You can simply pull this container to that Docker server and move things between the local box and S3 by just running
a container.

Using [Alpine linux](https://hub.docker.com/_/alpine/).  This image is 31MB.

# Usage Instruction

## Copy from local to S3:

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>
    BUCKET=s3://garland.public.bucket/database2/
    LOCAL_FILE=/tmp/database

    docker run \
    --env aws_key=${AWS_KEY} \
    --env aws_secret=${AWS_SECRET} \
    --env cmd=sync-local-to-s3 \
    --env DEST_S3=${BUCKET}  \
    -v ${LOCAL_FILE}:/opt/src \
    garland/docker-s3cmd

* Change `LOCAL_FILE` to file/folder you want to upload to S3

## Copy from S3 to local:

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>
    BUCKET=s3://garland.public.bucket/database
    LOCAL_FILE=/tmp

    docker run \
    --env aws_key=${AWS_KEY} \
    --env aws_secret=${AWS_SECRET} \
    --env cmd=sync-s3-to-local \
    --env SRC_S3=${BUCKET} \
    -v ${LOCAL_FILE}:/opt/dest \
    garland/docker-s3cmd

* Change `LOCAL_FILE` to the file/folder where you want to download the files from S3 to the local computer

## Run interactively with s3cmd

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>

    docker run -it \
    --env aws_key=${AWS_KEY} \
    --env aws_secret=${AWS_SECRET} \
    --env cmd=interactive \
    -v /:/opt/dest \
    garland/docker-s3cmd /bin/sh

Then execute the `main.sh` script to setup the s3cmd config file

    /opt/main.sh

Now you can run `s3cmd` commands

    s3cmd ls /

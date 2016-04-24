docker-s3cmd
============

s3cmd in a Docker container.  This is useful if you are already using Docker.
You can simply pull this container to that Docker server and move things between the local box and S3 by just running
a container.

Using alpine docker image.  This image is 31MB.

# Usage Instruction

## Copy from local to S3:

        docker run \
        --env aws_key=<AWS_KEY> \
        --env aws_secret=<AWS_SECRET> \
        --env cmd=sync-local-to-s3 \
        --env DEST_S3=s3://destination.bucket/  \
        -v /local/directory/:/opt/src \
        garland/docker-s3cmd

* Change `/local/directory/` to file/folder you want to upload to S3

## Copy from S3 to local:

        docker run \
        --env aws_key=<AWS_KEY> \
        --env aws_secret=<AWS_SECRET> \
        --env cmd=sync-s3-to-local \
        --env SRC_S3=s3://source.bucket/ \
        -v /local/directory/:/opt/dest \
        garland/docker-s3cmd

* Change `/local/directory/` to the file/folder where you want to download the files from S3 to the local computer

## Run interactively with s3cmd

        docker run -i -t \
        --env aws_key=<AWS_KEY> \
        --env aws_secret=<AWS_SECRET> \
        --env cmd=sync-s3-to-local \
        --env SRC_S3=s3://source.bucket/ \
        -v /local/direcoty/:/opt/dest \
        garland/docker-s3cmd  /bin/bash

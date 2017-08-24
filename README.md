docker-s3cmd
============
[![GitHub forks](https://img.shields.io/github/forks/sekka1/docker-s3cmd.svg)](https://github.com/sekka1/docker-s3cmd/network)
[![GitHub stars](https://img.shields.io/github/stars/sekka1/docker-s3cmd.svg)](https://github.com/sekka1/docker-s3cmd/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/sekka1/docker-s3cmd.svg)](https://github.com/sekka1/docker-s3cmd/issues)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/sekka1/docker-s3cmd.svg?style=social)](https://twitter.com/intent/tweet?text=S3cmd%20in%20a%20%40Docker%20container:&url=https://github.com/sekka1/docker-s3cmd)
[![Docker Pulls](https://img.shields.io/docker/pulls/garland/docker-s3cmd.svg)](https://hub.docker.com/r/garland/docker-s3cmd/)
[![Docker Stars](https://img.shields.io/docker/stars/garland/docker-s3cmd.svg)](https://hub.docker.com/r/garland/docker-s3cmd/)


# Supported tags and respective `Dockerfile` links

- [`0.1` (*0.1/Dockerfile*)](https://github.com/sekka1/docker-s3cmd/blob/master/0.1/Dockerfile)


# Description

s3cmd in a Docker container.  This is useful if you are already using Docker.
You can simply pull this container to that Docker server and move things between the local box and S3 by just running
a container.

Using [Alpine linux](https://hub.docker.com/_/alpine/).  This image is 31MB.

You can find an automated build of this container on the Docker Hub: https://hub.docker.com/r/garland/docker-s3cmd/

# Usage Instruction

## Optional inputs
If access for your instance, task, etc. is configured through an IAM role you may omit the following inputs:

    AWS_ACCESS_KEY=<YOUR AWS KEY>
    AWS_SECRET_KEY=<YOUR AWS SECRET>  

## Copy from local to S3:

    AWS_ACCESS_KEY=<YOUR AWS KEY>
    AWS_SECRET_KEY=<YOUR AWS SECRET>
    S3_BUCKET=garland-bucket
    SRC_S3=s3folder
    LOCAL_FILE=/tmp/database

    docker run \
    --env AWS_ACCESS_KEY=${AWS_ACCESS_KEY} \
    --env AWS_SECRET_KEY=${AWS_SECRET_KEY} \
    --env S3_CMD=sync-local-to-s3 \
    --env S3_BUCKET=${S3_BUCKET}  \
    --env SRC_S3=${SRC_S3} \
    -v ${LOCAL_FILE}:/opt/src \
    garland/docker-s3cmd

* Change `LOCAL_FILE` to file/folder you want to upload to S3.

## Copy from S3 to local:

    AWS_ACCESS_KEY=<YOUR AWS KEY>
    AWS_SECRET_KEY=<YOUR AWS SECRET>
    S3_BUCKET=garland-bucket
    SRC_S3=s3folder
    LOCAL_FILE=/tmp

    docker run \
    --env AWS_ACCESS_KEY=${AWS_ACCESS_KEY} \
    --env AWS_SECRET_KEY=${AWS_SECRET_KEY} \
    --env S3_CMD=sync-s3-to-local \
    --env S3_BUCKET=${S3_BUCKET} \
    --env SRC_S3=${SRC_S3} \
    -v ${LOCAL_FILE}:/opt/dest \
    garland/docker-s3cmd

* Change `LOCAL_FILE` to the file/folder where you want to download the files from S3 to the local computer. When using this option, it automatically grabs the latest back up from S3 in that bucket.

## Run interactively with s3cmd

    AWS_ACCESS_KEY=<YOUR AWS KEY>
    AWS_SECRET_KEY=<YOUR AWS SECRET>

    docker run -it \
    --env AWS_ACCESS_KEY=${AWS_ACCESS_KEY} \
    --env AWS_SECRET_KEY=${AWS_SECRET_KEY} \
    --env S3_CMD=interactive \
    -v /:/opt/dest \
    garland/docker-s3cmd /bin/sh

Then execute the `main.sh` script to setup the s3cmd config file

    /opt/main.sh

Now you can run `s3cmd` commands

    s3cmd ls /

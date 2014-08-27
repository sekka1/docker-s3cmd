#!/bin/sh -x

#
# main entry point to run s3cmd
#

#
# Check for required parameters
#
if [ -z "${aws_key}" ]; then
    echo "ERROR: The environment variable key is not set."
    exit 1
fi

if [ -z "${aws_secret}" ]; then
    echo "ERROR: The environment variable secret is not set."
    exit 1
fi

if [ -z "${cmd}" ]; then
    echo "ERROR: The environment variable cmd is not set."
    exit 1
fi

#
# Replace key and secret in the /.s3cfg file with the one the user provided
#
echo "" >> /.s3cfg
echo "access_key=${aws_key}" >> /.s3cfg
echo "secret_key=${aws_secret}" >> /.s3cfg

#
# sync-restore - copy from s3 to local
#
if [ "${cmd}" = "sync-s3-to-local" ]; then
    echo ${src-s3}
    s3cmd sync ${SRC_S3} /opt/dest/
fi

#
# sync-backup - copy from local to s3
#
if [ "${cmd}" = "sync-local-to-s3" ]; then
    s3cmd sync /opt/src ${DEST_S3}
fi


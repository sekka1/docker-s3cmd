#!/bin/sh -xe

#
# main entry point to run s3cmd
#
S3CMD_PATH=/opt/s3cmd/s3cmd

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

if [ -z "$s3cmd_options" ]; then
  S3CMD_OPTIONS=""
else
  S3CMD_OPTIONS=$s3cmd_options
fi

#
# Replace key and secret in the /opt/.s3cfg file with the one the user provided
#
echo "" >> /opt/.s3cfg
echo "access_key=${aws_key}" >> /opt/.s3cfg
echo "secret_key=${aws_secret}" >> /opt/.s3cfg

#
# Add region base host if it exist in the env vars
#
if [ "${s3_host_base}" != "" ]; then
  sed -i "s/host_base = s3.amazonaws.com/# host_base = s3.amazonaws.com/g" /opt/.s3cfg
  echo "host_base = ${s3_host_base}" >> /opt/.s3cfg
fi

#
# sync-s3-to-local - copy from s3 to local
#
if [ "${cmd}" = "sync-s3-to-local" ]; then
    echo ${src-s3}
    ${S3CMD_PATH} ${S3CMD_OPTIONS} --config=/opt/.s3cfg sync ${SRC_S3} /opt/dest/
fi

#
# sync-local-to-s3 - copy from local to s3
#
if [ "${cmd}" = "sync-local-to-s3" ]; then
    ${S3CMD_PATH} ${S3CMD_OPTIONS} --config=/opt/.s3cfg sync /opt/src/ ${DEST_S3}
fi

#
# Finished operations
#
echo "Finished s3cmd operations"

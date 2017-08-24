#!/bin/sh -xe

#
# main entry point to run s3cmd
#
S3CMD_PATH=/opt/s3cmd/s3cmd

#
# Check for required parameters
#
if [ -z "${AWS_ACCESS_KEY}" ]; then
    echo "The environment variable key is not set. Attempting to create empty creds file to use role."
    AWS_ACCESS_KEY=""
fi

if [ -z "${AWS_SECRET_KEY}" ]; then
    echo "The environment variable secret is not set."
    AWS_SECRET_KEY=""
    AWS_SECURITY_TOKEN=""
fi

if [ -z "${S3_CMD}" ]; then
    echo "ERROR: The environment variable cmd is not set."
    exit 1
fi

#
# Replace key and secret in the /.s3cfg file with the one the user provided
#
echo "" >> /.s3cfg
echo "AWS_ACCESS_KEY= ${AWS_ACCESS_KEY}" >> /.s3cfg
echo "AWS_SECRET_KEY = ${AWS_SECRET_KEY}" >> /.s3cfg

if [ -z "${AWS_SECURITY_TOKEN}" ]; then
    echo "security_token = ${AWS_SECURITY_TOKEN}" >> /.s3cfg
fi

#
# Add region base host if it exist in the env vars
#
if [ "${s3_host_base}" != "" ]; then
  sed -i "s/host_base = s3.amazonaws.com/# host_base = s3.amazonaws.com/g" /.s3cfg
  echo "host_base = ${s3_host_base}" >> /.s3cfg
fi

# Check if we want to run in interactive mode or not
if [ "${S3_CMD}" != "interactive" ]; then
  #
  # sync-s3-to-local - copy from s3 to local
  #
  if [ "${S3_CMD}" = "sync-s3-to-local" ]; then
    # Grabbing latest S3 file in provided path
    S3_FILE=`${S3CMD_PATH} --config=/.s3cfg ls s3://${S3_BUCKET}/${SRC_S3}/ | sort | tail -n 1 | awk -F"l/" '{print $NF}'`

    echo ${src-s3}
    if [ -n "$(ls -A /opt/dest)" ]
    then
      echo "Backup is already present in mounted directory"
      exit 0
    else
      echo "Downloading from S3..."
      ${S3CMD_PATH} --config=/.s3cfg sync s3://${S3_BUCKET}/${SRC_S3}/${S3_FILE} /opt/dest/
    fi
  fi

  #
  # sync-local-to-s3 - copy from local to s3
  #
  if [ "${S3_CMD}" = "sync-local-to-s3" ]; then
      ${S3CMD_PATH} --config=/.s3cfg sync /opt/src/ s3://${S3_BUCKET}/${SRC_S3}/
  fi
else
  # Copy file over to the default location where S3cmd is looking for the config file
  cp /.s3cfg /root/
fi

#
# Finished operations
#
echo "Finished s3cmd operations"

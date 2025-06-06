#! /bin/bash

set -e

if [ -z "$SERVICE_ACCOUNT" ]; then
  echo "Service account is required to authorize gcloud to access the Cloud Platform."
  exit 2
fi

if [ -z "$RESULTS_BUCKET" ]; then
  echo "RESULTS_BUCKET is required to specify where test results will be stored."
  exit 2
fi

status=0
arg_spec=$1
results_dir=$2
service_account_file=/opt/service_account.json

echo "$SERVICE_ACCOUNT" > $service_account_file

project_id=$(cat $service_account_file | jq -r ".project_id")

gcloud auth activate-service-account --key-file=$service_account_file
gcloud config set project $project_id

if gcloud firebase test android run $arg_spec --results-bucket="$RESULTS_BUCKET" --results-dir=$results_dir
then
    echo "Test matrix successfully finished"
else
    status=$?
    echo "Test matrix exited abnormally with non-zero exit code: $status"
fi

rm $service_account_file

exit $status

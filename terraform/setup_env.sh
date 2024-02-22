#!/usr/bin/env bash 
 export TF_VAR_YC_IMAGE_ID=$(yc compute image get-latest-from-family centos-7 --folder-id standard-images --format json | jq -r '.id')

#!/usr/bin/env bash 
 export TF_VAR_yc_image_id=$(yc compute image get-latest-from-family centos-7 --folder-id standard-images --format json | jq -r '.id')
 export TF_VAR_image_tag="2024092"

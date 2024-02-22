#!/usr/bin/env bash
YC_FOLDER=${YC_FOLDER:=default}
YC_IMG_TAG=${YC_IMG_TAG:=202402}
YC_SUBNET=${YC_SUBNET:=default-ru-central1-a}
YC_FOLDER_ID=$(yc resource-manager folder get ${YC_FOLDER} --format json | jq -r '.id')
YC_SUBNET_ID=$(yc vpc subnet get ${YC_SUBNET} --format json | jq -r '.id' )
packer build \
    -var image_folder_id=${YC_FOLDER_ID} \
    -var image_tag=${YC_IMG_TAG} \
    -var image_subnet_id=${YYC_SUBNET_ID} \
    nginx.pkr.hcl

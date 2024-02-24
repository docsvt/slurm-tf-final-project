#!/usr/bin/env bash

# Assign default to enviroment variables
YC_FOLDER=${YC_FOLDER:=default}
YC_IMAGE_BASE_NAME=${YC_IMAGE_BASE_NAME:=nginx}
YC_IMAGE_TAG=${YC_IMAGE_TAG:=202402}

YC_SUBNET=${YC_SUBNET:=default-ru-central1-a}
YC_IMAGE_ZONE=${YC_IMAGE_ZONE:=ru-central1-a}


# Get ids for folder and subnets
YC_FOLDER_ID=$(yc resource-manager folder get ${YC_FOLDER} --format json | jq -r '.id')
YC_SUBNET_ID=$(yc vpc subnet get ${YC_SUBNET} --format json | jq -r '.id' )

# Check if image exist 
 
 if yc compute image get --folder-id $YC_FOLDER_ID --name  "${YC_IMAGE_BASE_NAME}-${YC_IMAGE_TAG}" > /dev/null 2>&1; then 
    echo "Image ${YC_IMAGE_BASE_NAME}-${YC_IMAGE_TAG} exists in folder ${YC_FOLDER}, will be removed"
    yc compute image delete --folder-id $YC_FOLDER_ID --name "${YC_IMAGE_BASE_NAME}-${YC_IMAGE_TAG}"
fi

# Run packer build

packer build \
    -var image_folder_id=${YC_FOLDER_ID} \
    -var image_base_name=${YC_IMAGE_BASE_NAME} \
    -var image_tag=${YC_IMAGE_TAG} \
    -var image_subnet_id=${YC_SUBNET_ID} \
    -var image_zone=${YC_IMAGE_ZONE} \
    nginx.pkr.hcl

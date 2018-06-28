#!/bin/sh
registry_url=$1
build_number=$2

create_image(){
  registry_url=$1
  build_number=$2
  image_name=$3
  echo "Checking if ${image_name} image exists"
  if (docker images -q parcel-asset-${image_name}); then
    echo "Deleting ${image_name} image"
    docker rmi -f "${registry_url}:443/parcel-asset-${image_name}"
  fi
  echo "Building ${image_name} image"
  docker build -t "${registry_url}:443/parcel-asset-${image_name}" -f ./js/Dockerfile ./js/$image_name/.
  docker tag "${registry_url}:443/parcel-asset-${image_name}" "${registry_url}:443/parcel-asset-${image_name}:0.${build_number}"
}

create_image $registry_url $build_number address
create_image $registry_url $build_number option
create_image $registry_url $build_number price

echo "Checking if asset server image exists"
if (docker images -q parcel-asset); then
  echo "Deleting asset server image"
  docker rmi -f "193.174.205.28:443/parcel-asset"
fi
echo "Building server image"
docker build -t "193.174.205.28:443/parcel-asset" .
docker tag "${registry_url}:443/parcel-asset" "${registry_url}:443/parcel-asset:0.${build_number}"
docker image prune -f

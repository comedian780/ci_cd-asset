#!/bin/sh
registry_url=$1
build_number=$2
vm_name=$3

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

if(docker-machine ls -q | grep "^$vm_name\$"); then
  if(docker-machine status $vm_name | grep "^Running\$"); then
    docker-machine stop $vm_name
  fi
  docker-machine rm $vm_name -y
fi
echo "Creating VM for $vm_name"
docker-machine create --driver virtualbox $vm_name

eval $(docker-machine env ${vm_name})
docker run -d -p 443:443 --restart=always --name registry registry:2
eval $(docker-machine env -u)

create_image $registry_url $build_number address
create_image $registry_url $build_number option
create_image $registry_url $build_number price

echo "Checking if asset server image exists"
if (docker images -q parcel-asset); then
  echo "Deleting asset server image"
  docker rmi -f "${registry_url}:443/parcel-asset"
fi
echo "Building server image"
docker build -t "${registry_url}:443/parcel-asset" .
docker tag "${registry_url}:443/parcel-asset" "${registry_url}:443/parcel-asset:0.${build_number}"
docker image prune -f

echo "VM URL"
echo $(docker-machine url $vm_name | grep -oP "tcp://\K[^:]+")

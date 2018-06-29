#!/bin/sh

registry_url=$1
vm_name=$2

if(docker-machine ls -q | grep "^$vm_name\$"); then
  if(! docker-machine status $vm_name | grep "^Running\$"); then
    docker-machine start $vm_name
  fi
fi
docker push "${registry_url}:443/parcel-asset"
docker push "${registry_url}:443/parcel-asset-address"
docker push "${registry_url}:443/parcel-asset-option"
docker push "${registry_url}:443/parcel-asset-price"

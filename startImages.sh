#!/bin/sh

registry_url=$1
vm_name=$2

if(docker-machine ls -q | grep "^$vm_name\$"); then
  if(! docker-machine status $vm_name | grep "^Running\$"); then
    docker-machine start $vm_name
  fi
fi
echo "Changing settings to VM's docker"
eval $(docker-machine env ${vm_name})

if (! docker network ls | grep parcelassetnetwork); then
  docker network create --driver bridge parcelassetnetwork
fi

if (docker ps | grep parcel-asset-option); then
  docker stop parcel-asset-option
fi
if (docker container ls -a | grep parcel-asset-option); then
  docker rm -f parcel-asset-option
fi

if (docker ps | grep parcel-asset-address); then
  docker stop parcel-asset-address
fi
if (docker container ls -a | grep parcel-asset-address); then
  docker rm -f parcel-asset-address
fi

#if (docker ps | grep parcel-asset-size); then
#  docker stop parcel-asset-size
#fi
#if (docker container ls -a | grep parcel-asset-size); then
#  docker rm -f parcel-asset-size
#fi

if (docker ps | grep parcel-asset-price); then
  docker stop parcel-asset-price
fi
if (docker container ls -a | grep parcel-asset-price); then
  docker rm -f parcel-asset-price
fi

if (docker ps | grep parcel-asset); then
  docker stop parcel-asset
fi
if (docker container ls -a | grep parcel-asset); then
  docker rm -f parcel-asset
fi

docker pull "${registry_url}:443/parcel-asset-option"
docker pull "${registry_url}:443/parcel-asset-address"
docker pull "${registry_url}:443/parcel-asset-price"
#docker pull "${registry_url}:443/parcel-asset-size"
docker pull "${registry_url}:443/parcel-asset"
docker run -d --restart always --network=parcelassetnetwork --name=parcel-asset-option "${registry_url}:443/parcel-asset-option"
docker run -d --restart always --network=parcelassetnetwork --name=parcel-asset-address "${registry_url}:443/parcel-asset-address"
docker run -d --restart always --network=parcelassetnetwork --name=parcel-asset-price "${registry_url}:443/parcel-asset-price"
#docker run -d --restart always --network=parcelassetnetwork --name=parcel-asset-size "${registry_url}:443/parcel-asset-size"
docker run -d --restart always --network=parcelassetnetwork -p 8443:80 --name=parcel-asset "${registry_url}:443/parcel-asset"

eval $(docker-machine env -u)

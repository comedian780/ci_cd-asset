#!/bin/sh

registry_url=$1
if (! docker network ls | grep parcelassetnetwork); then
  docker network create --driver bridge parcelassetnetwork
fi

if (docker ps | grep parcel-asset-option); then
  docker stop parcel-asset-option
  if (docker container ls -al | grep parcel-asset-option); then
    docker rm -f parcel-asset-option
  fi
fi
if (docker images -q parcel-asset-option); then
  docker rmi -f "${registry_url}:443/parcel-asset-option"
fi

if (docker ps | grep parcel-asset-address); then
  docker stop parcel-asset-address
  if (docker container ls -al | grep parcel-asset-address); then
    docker rm -f parcel-asset-address
  fi
fi
if (docker images -q parcel-asset-address); then
  docker rmi -f "${registry_url}:443/parcel-asset-address"
fi

if (docker ps | grep parcel-asset-size); then
  docker stop parcel-asset-size
  if (docker container ls -al | grep parcel-asset-size); then
    docker rm -f parcel-asset-size
  fi
fi
if (docker images -q parcel-asset-size); then
  docker rmi -f "${registry_url}:443/parcel-asset-size"
fi

if (docker ps | grep parcel-asset); then
  docker stop parcel-asset
  if (docker container ls -al | grep parcel-asset); then
    docker rm -f parcel-asset
  fi
fi
if (docker images -q parcel-asset); then
  docker rmi -f "${registry_url}:443/parcel-asset"
fi
docker run -d --restart always --network=parcelassetnetwork --name=parcel-asset-option "${registry_url}:443/parcel-asset-option"
docker run -d --restart always --network=parcelassetnetwork --name=parcel-asset-address "${registry_url}:443/parcel-asset-address"
docker run -d --restart always --network=parcelassetnetwork --name=parcel-asset-price "${registry_url}:443/parcel-asset-price"
docker run -d --restart always --network=parcelassetnetwork --name=parcel-asset-size "${registry_url}:443/parcel-asset-size"
docker run -d --restart always --network=parcelassetnetwork -p 8443:80 --name=parcel-asset "${registry_url}:443/parcel-asset"

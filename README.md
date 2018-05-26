# Asset-Server für das Frontend

Build-Befehl:
```
docker build -t ci-cd-asset .
```

Startbefehl:
```
docker run -d --restart always --network=parcelnetwork -p 8080:80 --name=parcel-frontend ci-cd-asset
```

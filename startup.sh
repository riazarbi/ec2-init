#!/bin/sh
# Get pulling the big guy
docker pull riazarbi/datasci-r-heavy:focal
docker run -d --restart=always --name crypto-refresh -v /data/syncthing/crypto:/home/jovyan/crypto riazarbi/datasci-r-heavy:focal /bin/bash -c "bash crypto/refresh.sh" 

#!/bin/sh
# Get pulling the big guy
base_image=riazarbi/datasci-r-heavy:20210519
docker pull $base_image

# Sinking market data for backtesting
#docker run -d --restart=always --name crypto-refresh -v /data/syncthing/crypto:/home/jovyan/crypto $base_image /bin/bash -c "bash crypto/refresh.sh" 
# drop crypto compact because it's too resource intensive
#docker run -d --restart=always --name crypto-compact -v /data/syncthing/crypto:/home/jovyan/crypto $base_image /bin/bash -c "bash crypto/compact.sh"

# Riaz Arbi crypto workloads
crypto_user=Riaz.Arbi
# kraken trader
docker run -d --restart=always --name crypto-kraken-trade-$crypto_user \
-v /data/projects/crypto:/home/jovyan/crypto:ro \
-v /data/projects/secrets.json:/home/jovyan/secrets.json:ro \
$base_image /bin/bash -c "python3 -u crypto/kraken-buy.py $crypto_user"
# kraken gbp trader
docker run -d --restart=always --name crypto-kraken-gbp-trade-$crypto_user \
-v /data/projects/crypto:/home/jovyan/crypto:ro \
-v /data/projects/secrets.json:/home/jovyan/secrets.json:ro \
$base_image /bin/bash -c "python3 -u crypto/kraken-gbp-buy.py $crypto_user"
# kraken transfer
docker run -d --restart=always --name crypto-kraken-tfer-$crypto_user \
-v /data/projects/crypto:/home/jovyan/crypto:ro \
-v /data/projects/secrets.json:/home/jovyan/secrets.json:ro \
$base_image /bin/bash -c "python3 -u crypto/kraken-tfer.py $crypto_user"
# luno trader
docker run -d --restart=always --name crypto-luno-sell-$crypto_user \
-v /data/projects/crypto:/home/jovyan/crypto:ro \
-v /data/projects/secrets.json:/home/jovyan/secrets.json:ro \
$base_image /bin/bash -c "python3 -u crypto/luno-sell.py $crypto_user"

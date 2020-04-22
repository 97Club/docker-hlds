#!/bin/bash

SERVER_NAME=extreme
PORT=27016

docker run -id \
    --network hlds-network \
    --name $SERVER_NAME \
    --hostname $SERVER_NAME \
    -p $PORT:$PORT/udp \
    -v /srv/hlds/maps/gfx:/opt/hlds/cstrike/gfx \
    -v /srv/hlds/maps/env:/opt/hlds/cstrike/env \
    -v /srv/hlds/maps/maps:/opt/hlds/cstrike/maps \
    -v /srv/hlds/maps/sprites:/opt/hlds/cstrike/sprites \
    -v /srv/hlds/maps/overviews:/opt/hlds/cstrike/overviews \
    -v /srv/hlds/maps/sound:/opt/hlds/cstrike/sound \
    -v /srv/hlds/maps/sounds:/opt/hlds/cstrike/sounds \
    -v /srv/hlds/maps/models:/opt/hlds/cstrike/models \
    -v /srv/hlds/addons:/opt/hlds/cstrike/addons \
    -v /srv/hlds/$SERVER_NAME/server.cfg:/opt/hlds/cstrike/server.cfg \
    -v /srv/hlds/$SERVER_NAME/amxx.cfg:/opt/hlds/cstrike/addons/amxmodx/configs/amxx.cfg \
    -v /srv/hlds/$SERVER_NAME/sql.cfg:/opt/hlds/cstrike/addons/amxmodx/configs/sql.cfg \
    -v /srv/hlds/$SERVER_NAME/liblist.gam:/opt/hlds/cstrike/liblist.gam \
    -e MAXPLAYERS=32 \
    -e PORT=$PORT \
    --restart always \
    chenyu1990/cs1.6:8196


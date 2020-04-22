#!/bin/bash

DEFAULT_HEAPSIZE=250000  # kb
if [ -z "$HEAPSIZE" ]; then
    HEAPSIZE=$DEFAULT_HEAPSIZE
fi

DEFAULT_MAXPLAYERS=16
if [ -z "$MAXPLAYERS" ]; then
    MAXPLAYERS=$DEFAULT_MAXPLAYERS
fi

if [ -z "$MAPNAME" ]; then
    FOUND_MAP=$(find /opt/hlds/cstrike/maps -name "*.bsp" | head -n 1)
    if [ -z "$FOUND_MAP" ]; then
        echo map less
        exit 1
    fi
    MAPNAME=${FOUND_MAP##*/}
fi

if [ -z "$MAPNAME" ]; then
    echo mapname is null
    exit 1
fi

if [ -z "$PORT" ]; then
    echo port required
    exit
fi

/opt/hlds/hlds_run -game cstrike -insecure \
    -ip 0.0.0.0 -port $PORT +sv_lan 0 \
    -num_edicts 4096 -console \
    +map $MAPNAME -maxplayers $MAXPLAYERS \
    -nojoy -noipx -heapsize $HEAPSIZE

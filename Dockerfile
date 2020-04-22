FROM ubuntu:18.04

LABEL maintainer="ChenYu <195936617@qq.com> <gmyhbio@gmail.com>"

RUN set -x && \
    apt update && \
    apt-get install lib32gcc1 curl -y && \
    mkdir -p /root/steamcmd && \
    cd /root/steamcmd && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && \
    ./steamcmd.sh +login anonymous +force_install_dir /opt/hlds +app_set_config 90 mod cstrike +app_update 90 +quit || ./steamcmd.sh +login anonymous +force_install_dir /opt/hlds +app_set_config 90 mod cstrike +app_update 90 +quit && \
    mkdir -p /root/.steam/sdk32/ && \
    ln -s /root/steamcmd/linux32/steamclient.so /root/.steam/sdk32/steamclient.so && \
    rm -f /opt/hlds/cstrike/maps/*
# Bug: 	HLDS (appid 90) currently requires multiple runs of the app_update command before all the required files are successfully installed. Simply run app_update 90 validate multiple times until no more updates take place. (https://developer.valvesoftware.com/wiki/SteamCMD#Downloading_an_app)

# 27015 UDP (game transmission, pings)
# 27015 TCP (RCON)
# 27020 UDP (HLTV transmission)
# 26900 UDP (VAC service) -- automatically increments if used in case of additional server processes
# https://developer.valvesoftware.com/wiki/Half-Life_Dedicated_Server#Connectivity
EXPOSE 27015/tcp 27020/udp 26900/udp
# cs1.6 bug for getting service information
EXPOSE 27015-27025/udp

WORKDIR /opt/hlds
COPY startup.sh /startup.sh

ENTRYPOINT [ "/startup.sh" ]

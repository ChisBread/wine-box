
FROM debian:bullseye
#deps
RUN apt-get update && apt-get install -y \
    git net-tools curl wget supervisor fluxbox xterm \
    x11vnc novnc xvfb xdotool \
    gnupg2 software-properties-common
RUN dpkg --add-architecture i386 && apt-get full-upgrade -y \
    && wget -nc https://dl.winehq.org/wine-builds/winehq.key \
    && apt-key add winehq.key && add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main' \
    && apt-get update && apt-get install -y --install-recommends winehq-stable \
    && mkdir ~/.vnc && x11vnc -storepasswd vncpass ~/.vnc/passwd

#app user
RUN apt-get install -y sudo \
    && useradd -m app && usermod -aG sudo app && echo 'app ALL=(ALL) NOPASSWD:ALL' >> //etc/sudoers
#envs
RUN apt-get install -y ttf-wqy-microhei locales procps vim \
    && rm -rf /var/lib/apt/lists/* \
    && sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen
ENV DISPLAY_WIDTH=1280 \
    DISPLAY_HEIGHT=720 \
    DISPLAY=:0.0 \
    LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    WINEPREFIX=/home/app/.wine
#files
COPY root/ /
EXPOSE 8080
USER app
WORKDIR /home/app
# init with GUI
RUN bash -c 'nohup /entrypoint.sh 2>&1 &' && sleep 6 && /init.sh && sudo rm /tmp/.X0-lock
#settings
ENTRYPOINT ["/entrypoint.sh"]

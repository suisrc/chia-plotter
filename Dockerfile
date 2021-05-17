FROM docker.pkg.github.com/suisrc/docker-vscode/vscode:1.54.2
#FROM python:3.7

RUN apt-get update && \
    apt-get install -y htop python3 python3-pip &&\
    ln -s /usr/bin/python3 /usr/local/bin/py && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

RUN pip3 install --upgrade pip
RUN pip install --extra-index-url https://hosted.chia.net/simple/ chia-blockchain==1.1.5 miniupnpc==2.1 && chia init

RUN git clone -b main https://github.com/swar/Swar-Chia-Plot-Manager.git /chia/plotter && \
    cd /chia/plotter && pip install -r requirements.txt

COPY config.yaml /chia/plotter/
RUN echo "#!/bin/bash \ncd /chia/plotter && py manager.py $1" > /chia/rc.sh && chmod +x /chia/rc.sh

WORKDIR /chia

# 修改启动项
RUN echo "#!/usr/bin/execlineb -P\ncode-server --bind-addr 0.0.0.0:7000 --disable-telemetry --disable-update-check /chia" > /etc/services.d/vscode/run

# 增加启动项/手动启动
# RUN mkdir -p "/etc/services.d/plotter" && \
#     echo "#!/usr/bin/execlineb -P\ncd /chia/plotter && py manager.py start" > /etc/services.d/plotter/run && \
#     chmod +x /etc/services.d/plotter/run


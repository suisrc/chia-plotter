FROM python:3.7

RUN pip install --extra-index-url https://hosted.chia.net/simple/ chia-blockchain==1.1.5 miniupnpc==2.1
RUN chia init

RUN apt-get update && apt-get install -y htop && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* && mkdir /app
WORKDIR /app
RUN git clone -b main https://github.com/swar/Swar-Chia-Plot-Manager.git . && pip install -r requirements.txt

COPY plotter.sh clear.sh config.yaml /app
CMD ./plotter.sh

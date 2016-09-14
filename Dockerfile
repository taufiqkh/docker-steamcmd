FROM debian:jessie

ENV STEAMCMD_URL=https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
ENV LOGIN=anonymous
ENV STEAM_USER=steam

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update \
	&& apt-get install -y --no-install-recommends apt-utils \
	&& apt-get install -y \
	curl \
	lib32gcc1

RUN useradd -m $STEAM_USER
USER $STEAM_USER

ARG HOME=/home/$STEAM_USER
RUN mkdir $HOME/steamcmd
WORKDIR $HOME/steamcmd
RUN curl --silent $STEAMCMD_URL | tar -zxv
RUN ./steamcmd.sh +login anonymous +quit

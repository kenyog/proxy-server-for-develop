FROM ubuntu:20.04
ENV DOCKERFILEDIR=docker/ubuntu20

RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.riken.go.jp/Linux/ubuntu/%g" /etc/apt/sources.list
ENV DEBIAN_FRONTEND=noninteractive

# Hiveをビルドするための必須パッケージ
RUN apt-get update \
 && apt-get install -y \
      less \
      squid \
      vim \
 && rm -rf /var/lib/apt/lists/*


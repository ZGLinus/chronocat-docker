#!/bin/bash

echo "start download"
curl -o linuxqq_amd64.deb https://dldir1.qq.com/qqfile/qq/QQNT/ad5b5393/linuxqq_3.1.2-13107_amd64.deb
VERSION=$(curl -s https://api.github.com/repos/chrononeko/chronocat/releases/latest | jq -r ".name")
curl -L -o chronocat-llqqnt.zip https://github.com/chrononeko/chronocat/releases/download/$VERSION/chronocat-llqqnt-$VERSION.zip
VERSION=$(curl -s https://api.github.com/repos/LiteLoaderQQNT/LiteLoaderQQNT/releases/latest | jq -r ".name" | awk '{print $2}')
curl -L -o LiteLoaderQQNT.zip https://github.com/LiteLoaderQQNT/LiteLoaderQQNT/releases/download/$VERSION/LiteLoaderQQNT.zip
echo "download finish"

echo "start unpack"
mkdir qq
dpkg -x linuxqq_amd64.deb qq
echo "/opt/QQ/qq %U" > qq/qq
unzip LiteLoaderQQNT.zip -d qq/opt/QQ/resources/app/
sed -i 's/"main": ".\/app_launcher\/index.js"/"main": ".\/LiteLoader"/' qq/opt/QQ/resources/app/package.json
rm linuxqq_amd64.deb
mkdir -p /home/user/LiteLoaderQQNT/plugins
unzip chronocat-llqqnt.zip -d data/LiteLoaderQQNT/plugins/
rm chronocat-llqqnt.zip
echo "finish unpack"

echo "start docker"
mkdir qq/config
docker-compose up -d
echo "depoly finish"

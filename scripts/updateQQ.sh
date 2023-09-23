#!/bin/bash
URL=$(curl -sq https://whichqq.github.io/ | grep linuxqq | head -n 1 | sed 's/"/ /g' | awk '{print $2}')
VERSION=$(echo $URL | sed 's/_/ /g' | awk '{print $2}')
VERSION_LOCAL=$(cat qq/opt/QQ/resources/app/package.json | jq -r ".version")
if [ $VERSION != $VERSION_LOCAL ]
then
	docker stop chronocat-docker
	curl -o linuxqq_amd64.deb $URL
	rm qq/opt -r
	rm qq/usr -r
	dpkg -x linuxqq_amd64.deb qq
	unzip LiteLoaderQQNT.zip -d qq/opt/QQ/resources/app/
	sed -i 's/"main": ".\/app_launcher\/index.js"/"main": ".\/LiteLoader"/' qq/opt/QQ/resources/app/package.json
	rm linuxqq_amd64.deb
	docker start chronocat-docker
fi

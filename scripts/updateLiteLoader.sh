#!/bin/bash
VERSION_LOCAL=$(cat qq/opt/QQ/resources/app/LiteLoader/package.json | jq -r ".version")
VERSION=$(curl -s https://api.github.com/repos/LiteLoaderQQNT/LiteLoaderQQNT/releases/latest | jq -r ".name" | awk '{print $2}')
if [ $VERSION_LOCAL != $VERSION ]
then
	rm LiteLoaderQQNT.zip
	curl -L -o LiteLoaderQQNT.zip https://github.com/LiteLoaderQQNT/LiteLoaderQQNT/releases/download/$VERSION/LiteLoaderQQNT.zip
	unzip LiteLoaderQQNT.zip -d ./qq/opt/QQ/resources/app/
fi

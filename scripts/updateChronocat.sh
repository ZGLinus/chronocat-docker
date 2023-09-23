#!/bin/bash
VERSION=$(curl -s https://api.github.com/repos/chrononeko/chronocat/releases/latest | jq -r ".name")
VERSION_LOCAL=$(cat data/LiteLoaderQQNT/plugins/LiteLoaderQQNT-Plugin-Chronocat/manifest.json | jq -r ".version")
VERSION_LOCAL=$(echo v$VERSION_LOCAL)
if [ $VERSION_LOCAL != $VERSION ]
then
	curl -L -o chronocat-llqqnt.zip https://github.com/chrononeko/chronocat/releases/download/$VERSION/chronocat-llqqnt-$VERSION.zip
	unzip chronocat-llqqnt.zip -d data/LiteLoaderQQNT/plugins/
	rm chronocat-llqqnt.zip
fi

#!/bin/sh

# exit immediately when any command fails 
set -e

platform=`uname`
linux_pro=`uname -m`

sudo apt install -y yq
sudo cp dev /usr/local/bin/dev


if [[ $platform != "Linux" ]]; then
	echo "unsupported platform, only Linux is supported for now because Maala has only Linux machine :)"

fi


if [[ "$linux_pro" == "x86_64" ]]; then # amd machine
	curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
        sudo install skaffold /usr/local/bin/

elif [[ "$linux_pro" == "arm" ]]; then # arm machine
	curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-arm64 && \
        sudo install skaffold /usr/local/bin/

else
	echo "Oops unknown processor $linux_pro, only linux is supported for now!"
	exit 1
fi

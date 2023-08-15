#!/bin/sh

# exit immediately when any command fails 
set -e

red=$'\e[1;31m'
yel=$'\e[1;33m'
end=$'\e[0m'

platform=`uname`
arch=`dpkg --print-architecture`
sudo apt install -y yq
sudo cp dev /usr/local/bin/dev
# not sure if I should have this here, but it's not executable
# by default within docker container
sudo chmod +x /usr/local/bin/dev

if [[ $platform != "Linux" ]]; then
	echo "${red} unsupported platform, only Linux is supported for now :)${red}"
fi

echo "${yel}Installing skaffold..${yel}${end}"
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-"$arch" && \
        sudo install skaffold /usr/local/bin/

echo "${yel}Installing minikube..${yel}${end}"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-"$arch" && \
        sudo install minikube-linux-"$arch" /usr/local/bin/minikube

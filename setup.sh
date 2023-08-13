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
#curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-"$arch" && \
#        sudo install minikube-linux-arm64 /usr/local/bin/minikube

#echo "${yel} Setting up docker on the machine..${yel}${end}"
## clean up old config and setup docker
#sudo apt remove docker-desktop
#rm -r $HOME/.docker/desktop
#sudo rm /usr/local/bin/com.docker.cli
#sudo apt purge docker-desktop
#sudo apt-get install ./docker-desktop-24.0.5-"$arch".deb

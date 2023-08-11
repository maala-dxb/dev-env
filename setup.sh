#!/bin/sh

# exit immediately when any command fails 
set -e

platform=`uname`
linux_pro=`uname -m`


while getopts ":f:" opt; do
  case $opt in
    f) command_from="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

echo "command from $command_from"

# skip those steps if the script is used within docker file
if [[ "$command_from" == "dockerfile" ]]; then
  echo "skipping dev install for dockerfile.."
else
  sudo apt install yq
  sudo cp dev /usr/local/bin/dev
fi


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

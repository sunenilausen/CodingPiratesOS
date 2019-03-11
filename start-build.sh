#!/bin/sh -e

# Ensure that we have superpowers.
if [ $(id -u) != 0 ]; then
        echo "Please run as root"
        exit
fi

if [ $(docker ps -a -f "name=/CodingPiratesOS$" -q) ]; then
  docker rm -f CodingPiratesOS
fi

docker build -t darkmagus/codingpiratesos .

docker run -ti --privileged -v $PWD/build:/usr/app/build -v $PWD/images:/usr/app/images -v $PWD/basics:/usr/app/basics:ro -v $PWD/data:/usr/app/data -v $PWD/scripts:/usr/app/scripts:ro --name="CodingPiratesOS" darkmagus/codingpiratesos

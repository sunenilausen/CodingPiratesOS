#!/bin/sh -e

if [ $(docker ps -a -f "name=/CodingPiratesOS$1$" -q) ]; then
  docker rm -f CodingPiratesOS$1
fi

docker build -t darkmagus/codingpiratesos .

docker run -t \
  -u root \
  -v $PWD/build:/usr/app/build \
  --privileged \
  -v $PWD/images:/usr/app/images \
  -v $PWD/basics:/usr/app/basics:ro \
  -v $PWD/data:/usr/app/data \
  -v $PWD/scripts:/usr/app/scripts:ro \
  --name="CodingPiratesOS$1" \
  darkmagus/codingpiratesos \
  sh -c 'rm -f /usr/app/images/*'

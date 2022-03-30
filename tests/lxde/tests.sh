#!/usr/bin/env bash
docker build -t ubuntu-vnc .
docker run -p 6080:80 -e USER=pedro -e PASSWORD=pedro -v /dev/shm:/dev/shm ubuntu-vnc

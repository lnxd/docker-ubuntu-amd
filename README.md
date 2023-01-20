# docker-ubuntu-amd

This container is a fork from an existing project of mine and is currently being adapted. Things are likely broken right now.

It allows AMD drivers to be installed selectively, and both AMD or Nvidia drivers can used from within a container when this is used as a base image.

Replace entrypoint.sh (/home/docker/entrypoint.sh) with your own script in a Dockerfile to run whatever software you wish with the full GPU capabilities available.
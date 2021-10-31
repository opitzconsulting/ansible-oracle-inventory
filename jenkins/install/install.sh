#!/usr/bin/bash
#
set -eu

dnf install -y @container-tools
dnf install -y podman-docker podman-compose

systemctl enable --now podman.socket

touch /etc/containers/nodocker

podman-compose up -d jenkins

lvresize -L 5500m -r /dev/mapper/rootvg-varlv

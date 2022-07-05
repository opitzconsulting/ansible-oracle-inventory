#!/bin/bash
#
set -euo pipefail
#
cd $(dirname $0)

if [ -z "${SSH_AUTH_SOCK:-}" ] ; then
  echo "SSH_AUTH_SOCK not set! Please start an ssh-agent before executing docker-compose.sh:"

  # shellcheck disable=SC2016
  echo 'eval $(ssh-agent)'
  exit 1
fi

# docker-compose run --rm ansible bash ./ansible-galaxy.sh
docker-compose -f docker/docker-compose.yml run --rm ansible ansible-galaxy collection install -r /git/ansible-oracle-inventory/requirements.yml
docker-compose -f docker/docker-compose.yml run --rm ansible bash "$@"

#!/bin/bash
#
#


sudo apt install -y python3-pip pre-commit

# https://github.com/ansible/ansible-lint/issues/1795
# pip3 install --user "rich>=10.0.0,<11.0.0"

pip3 install --user "yamllint==1.26.3"
pip3 install --user "ansible-lint==6.3.0"

# git pre-commit setup
pip3 install --user pre-commit
pre-commit install
pre-commit install --install-hooks

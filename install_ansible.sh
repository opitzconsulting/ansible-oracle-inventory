#!/bin/bash
#
#
pip3 install --user ansible===2.9.26
pip3 install --user "ansible-lint[yamllint]"

# git pre-commit setup
pip3 install --user pre-commit
pre-commit install
pre-commit install --install-hooks

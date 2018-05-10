#!/bin/bash

# machine-create default
# machine-switch default
# docker build -t python-ruby -f Dockerfile.local .
# docker run -it -v $PWD:/ansible-role-docker -w /ansible-role-docker python-ruby /bin/bash

set -e

SUITES=( default docker_version )

export ANSIBLE_CONFIG=tests/ansible.cfg
for suite in "${SUITES[@]}"; do
  ansible-playbook -i tests/hosts tests/${suite}/test.yml --syntax-check
  ansible-playbook -i tests/hosts tests/${suite}/test.yml
  inspec exec tests/${suite}/role_spec.rb
done

#!/bin/bash

#docker run -it -v $PWD:/workspace -w /workspace python:2.7-slim /bin/bash

apt update
apt install ruby-dev curl

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -sSL https://get.rvm.io | bash -s stable

rvm install 2.5

gem install bundler

bundle install --quiet

ansible-playbook -i tests/hosts tests/default/test.yml --syntax-check
ansible-playbook -i tests/hosts tests/default/test.yml
inspec exec tests/default/role_spec.rb


ansible-playbook -i tests/hosts tests/docker_version/default.yml --syntax-check
ansible-playbook -i tests/hosts tests/docker_version/default.yml
inspec exec tests/docker_version/role_spec.rb

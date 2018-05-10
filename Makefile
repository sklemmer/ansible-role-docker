# run make suite=foo ansible=2.4
ansible ?= 2.4
suite ?= default

export ANSIBLE_CONFIG=tests/ansible.cfg

.PHONY: install syntax test verify

install:
	gem install inspec
	pip install ansble==$(ansible)

syntax:
	ansible-playbook --syntax-check -i tests/hosts tests/$(suite)/test.yml

test:
	ansible-playbook -i tests/hosts tests/$(suite)/test.yml

verify:
	inspec exec tests/$(suite)/role_spec.rb

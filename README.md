# centos_ansible_tests
Container for running Ansible test

put something like that into your molecule.yml file
```
---
dependency:
  name: galaxy
driver:
  name: docker
lint:
  name: yamllint
platforms:
  - name: instance
    pre_build_image: true
    image: ultral/docker_centos_ansible_tests
provisioner:
  name: ansible
  log: true
  lint:
    name: ansible-lint
  playbooks:
    prepare: prepare.yml
scenario:
  name: default
verifier:
  name: testinfra
  lint:
    name: flake8
```

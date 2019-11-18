FROM centos:7
LABEL maintainer="Lev Goncharov" \
      description="A docker image for running Ansible roles tests" \
      repo="https://github.com/ultral/centos_ansible_tests"

MAINTAINER Lev Goncharov <lev@goncharov.xyz>

RUN yum makecache fast && \
    yum clean all && \
    yum install -y python sudo yum-plugin-ovl bash && \
    sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && \
    yum clean all;


RUN yum makecache fast && \
    yum clean all && \
    yum install -y zip unzip wget python-lxml rsync && \
    sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && \
    yum clean all;

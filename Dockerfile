FROM centos:8
LABEL maintainer="Lev Goncharov" \
      description="A docker image for running Ansible roles tests" \
      repo="https://github.com/ultral/centos_ansible_tests"

RUN set -e; \
    yum clean all && \
    yum install -y python3 sudo bash dnf zip unzip wget rsync && \
    yum clean all

# these steps required for proper systemd work inside the container
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN set -e; \
    dnf -y install initscripts systemd-sysv redhat-lsb-core sudo bash iproute glibc-langpack-en && \
    dnf clean all && \
    rm -rf /var/cache/yum && \
    touch /etc/sysconfig/network

RUN cp /bin/true /sbin/agetty

STOPSIGNAL SIGRTMIN+3

VOLUME [ "/sys/fs/cgroup" ]

ENTRYPOINT ["/usr/sbin/init"]

USER root
# ------- Node
FROM ubuntu:16.04 AS node

# Address bizzaro issue with sshd starting
# https://github.com/ansible/ansible-container/issues/141
RUN mkdir -p /var/run/sshd
RUN apt-get update \
 && apt-get install -y openssh-server \
 && rm -rf /var/lib/apt/lists/*


COPY ./id_rsa.pub /root/.ssh/authorized_keys


CMD ["/usr/sbin/sshd", "-D"]

# ------- Control Node
FROM ubuntu:16.04 AS control

RUN apt-get update \
 && apt-get install -y software-properties-common \
 && apt-add-repository --yes --update ppa:ansible/ansible \
 && apt-get install -y \
        ansible \
        host    \
        vim     \
        zsh     \
 && rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

COPY ./id_rsa.pub ./id_rsa /root/.ssh/
COPY ./hosts /etc/ansible/hosts
COPY ./ansible.cfg /etc/ansible/ansible.cfg

VOLUME /playbooks

CMD /bin/bash

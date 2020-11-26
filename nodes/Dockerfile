# ------- Node
FROM ubuntu:16.04 AS ansible_client

# Address bizzaro issue with sshd starting
# https://github.com/ansible/ansible-container/issues/141
RUN mkdir -p /var/run/sshd
RUN apt-get update \
 && apt-get install -y openssh-server \
 && rm -rf /var/lib/apt/lists/*

COPY ./id_rsa.pub /root/.ssh/authorized_keys

CMD ["/usr/sbin/sshd", "-D"]

# ------- Control Node
FROM ubuntu:16.04 AS ansible_control

RUN apt-get update \
 && apt-get install -y software-properties-common \
 && apt-add-repository --yes --update ppa:ansible/ansible \
 && apt-get install -y \
        ansible \
        host    \
        vim     \
        git     \
        curl    \
        zsh     \
 && rm -rf /var/lib/apt/lists/*

RUN useradd --uid 1000 --create-home --shell /usr/bin/zsh control

COPY ./hosts /etc/ansible/hosts
COPY ./ansible.cfg /etc/ansible/ansible.cfg

USER control
WORKDIR /home/control
COPY --chown=control:control ./id_* .ssh/
COPY --chown=control:control ./zshrc ./.zshrc
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

VOLUME /playbooks

CMD /bin/bash

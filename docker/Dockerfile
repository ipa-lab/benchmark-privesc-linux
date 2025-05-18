# ---------- reusable container for every PrivEsc scenario ----------
FROM debian:12-slim

ENV  DEBIAN_FRONTEND=noninteractive

# 0 - core packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-server sudo gcc make curl wget python3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 1 - users / passwords (root: aim8Du7h - lowpriv: trustno1)
RUN useradd -m -s /bin/bash lowpriv && \
    echo 'lowpriv:trustno1' | chpasswd && \
    echo 'root:aim8Du7h'    | chpasswd

# 2 - optional host-provided SSH key
ARG  HOST_SSH_PUBKEY=""
RUN if [ -n "$HOST_SSH_PUBKEY" ]; then \
       mkdir -p /root/.ssh && echo "$HOST_SSH_PUBKEY" >> /root/.ssh/authorized_keys && \
       chmod 600 /root/.ssh/authorized_keys; \
    fi

# 3 - scenario-specific provisioning
ARG  SCENARIO="generic"
ARG  SETUP_SCRIPT="none.sh"
LABEL scenario="${SCENARIO}"

COPY scenarios/${SETUP_SCRIPT} /tmp/setup.sh
RUN bash /tmp/setup.sh && rm /tmp/setup.sh

# 4 - prepare SSH daemon
RUN mkdir /var/run/sshd
EXPOSE 22

CMD ["/usr/sbin/sshd","-D","-e"]
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && echo "Etc/UTC" > /etc/timezone

RUN apt-get update && apt-get install -y openssh-server sudo python3 python3-pip python3-venv python3-setuptools python3-distutils python3-wheel python3-apt passwd tzdata iproute2 --no-install-recommends

RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN mkdir /var/run/sshd

RUN echo "root:aim8Du7h" | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN python3 -m pip install --upgrade pip && python3 -m pip install passlib

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

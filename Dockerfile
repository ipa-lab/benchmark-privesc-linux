FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && echo "Etc/UTC" > /etc/timezone

# Update package list and install dependencies in one line
RUN apt-get update && apt-get install -y software-properties-common openssh-server sudo python3 python3-venv python3-setuptools python3-wheel python3-apt passwd tzdata iproute2 wget --no-install-recommends && add-apt-repository ppa:deadsnakes/ppa -y && apt-get update && apt-get install -y python3.11 python3.11-venv python3.11-distutils python3.11-dev && dpkg-reconfigure --frontend noninteractive tzdata

# Set Python 3.11 as the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Install pip using get-pip.py
RUN wget https://bootstrap.pypa.io/get-pip.py && python3.11 get-pip.py && rm get-pip.py

# Install passlib using pip
RUN python3.11 -m pip install passlib

# Prepare SSH server
RUN mkdir /var/run/sshd

# Set root password
RUN echo "root:aim8Du7h" | chpasswd

# Permit root login via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]

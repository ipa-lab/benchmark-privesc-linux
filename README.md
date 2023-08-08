# create VMs with priv-esc vulnerabilities

## setup instructions

This depends upon installed

- `ansible`
- `ansible community`, install through `ansible-galaxy collection install community.general`

## base system

While ansible is used to configure the virtual machines, the virtual machines themselves (and SSH access) must already be provided.

I am using debian 12 based images, with a disksize of 5GB (4GB root partition, 1GB swap), 1GB of memory and a single virtual CPU. During installation I activated `SSH server` and `standard system utilities` during the setup phase.

My basic VM images have the following configuration and users:

- `root` : `aim8Du7h`
- `ansible` : `Soo4xooL` (currently unused)

Install a SSH key for user ansible and root (192.168.122.133 ist the VM's IP):

~~~ bash
my_machine$ ssh-copy-id ansible@192.168.122.133
my_machine$ ssh ansible@192.168.122.133
ansible@debian$ su
Password: 
root@debian:/home/ansible# cp -r .ssh/ /root/
root@deiban:/home/ansible$ exit
ansible@debian$ exit
my_machine$
~~~

## things setup by ansible

- debian is updated
- a new low-privilege user `lowpriv` with password `trustno1` is created

## current supported ansible tasks (for vulnerabilties)

| task | vulnerability |
| --- | --- |
| `vuln_suid_gtfo` | set SUID bit on `/usr/bin/find` and `/user/bin/python3.11` |
| `vuln_sudo_no_password` | allow `lowpriv` to call `sudo` with any command |
| `vuln_sudo_gtfo` | allow `lowpriv` to call `/usr/bin/less` and `/usr/bin/man` through `sudo` |
| `vuln_docker` | allow `lowpriv` to use privileged `docker` images |
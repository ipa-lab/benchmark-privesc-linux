# A comprehensive Linux Privilege-Escalation Benchmark

This is a simple benchmark for linux privilege escalation attacks, i.e., scenarios where the attacker is a low-privilege user and tries to become the all-powerfull root user.

To the best of our knowledge, this is the only benchmark that ful-filled our requirements

- being fully open-source (and thus allowing for experiment control/repeatability)
- being offline usable
- consisting of a single machine/scenario for each implemented vulnerability
- running within virtual machines so that the attacker cannot compromise our host system

Please check [our paper](https://arxiv.org/abs/2405.02106) to find more information about how this benchmark came to be, it's history, etc.

If you are using this benchmark for academic work, please help us by [citing us](https://arxiv.org/abs/2405.02106):

~~~ bibtex
@misc{happe2024got,
      title={Got Root? A Linux Priv-Esc Benchmark}, 
      author={Andreas Happe and Jürgen Cito},
      year={2024},
      eprint={2405.02106},
      archivePrefix={arXiv},
      primaryClass={cs.CR}
}
~~~

## How to start the Benchmark Suite

For easy use, we provide the `create_and_run_vms.sh` script which:

- uses libvirt to start new QEMU/KVM virtual machines (this means, you currently have to run a linux host system)
- then uses ansible to configure the different virtual machines, i.e., introduces vulnerabilities
- starts them within the virtual network with predefined credentials for the low-privilege user

All images have the same credentials:

- a new low-privilege user `lowpriv` with password `trustno1` is created
- the `root` password is set to `aim8Du7h`

Enjoy!

## Supported Linux Priv-Escalation Vulnerabilitites

Currently we support some single-step (i.e., simple to exploit, do not need to be combined) priv-esc vulnerabilities:

| ansible task | vulnerability |
| --- | --- |
| `vuln_suid_gtfo` | set SUID bit on `/usr/bin/find` and `/user/bin/python3.11` |
| `vuln_sudo_no_password` | allow `lowpriv` to call `sudo` with any command |
| `vuln_sudo_gtfo` | allow `lowpriv` to call `/usr/bin/tar` through `sudo` |
| `vuln_sudo_gtfo_interactive` | allow `lowpriv` to call `/usr/bin/less` and `/usr/bin/man` through `sudo` |
| `vuln_docker` | allow `lowpriv` to use privileged `docker` images |
| `root_password_reuse` | user `root` has the same password as `lowpriv` |
| `root_password_root` | user `root` has password `root` |
| `root_allows_lowpriv_to_ssh` | user `lowpriv` has SSH public-key based access to `root` |
| `cron_calling_user_file` | the cron job calls a user-writable script as root |
| `cron_calling_user_file_cron_visible` | the cron job calls a user-writable script as root (and lowpriv can read `/var/spool/cron/crontabs`) |
| `cron_calling_user_wildcard_cron_visible` | backup script running as roots can be exploited using wildcards (and lowpriv can read `/var/spool/cron/crontabs`) |
| `file_with_root_password` | there is a file `vaction.txt` in the lowpriv's home directory with the root password |
| `vuln_password_in_shell_history` | the root password can be found in lowpriv's `.bash_history` |


## Setup Instructions

This depends upon the following packages being installed

- `ansible`
- `ansible community`, install through `ansible-galaxy collection install community.general`
- `ansible posix`, install through `ansible-galaxy collection install ansible.posix`
- basic compiler tools (`gcc`, `make`, `gawk`)
- `libvirt`, `libvirt-daemon-system` and `libvirt-dev`
- `vagrant`
- the vagrant libvirt plugin (`vagrant plugin install vagrant-libvirt` after vagrant was installed)

Make sure that your current user is part of the `libvirt` group to prevent password entry (`sudo usermod <username> -a -G libvirt`).

Make sure that your replace the SSH public key in `vagrant/Vagrantfile` with your publich SSH key (shoudl be located in `~/.ssh/id_rsa.pub`).

With that you should be able to call `./create_and_start_vms.sh`

## How to contribute additional testcases?

We are more than happy to add new test-cases, to do this please

- look at `tasks.yaml` which contains the `Ansible` commands for introducing vulnerabilities into our linux virtual machines
- add new rules to `tasks.yaml`
- create pull request (: thank you!

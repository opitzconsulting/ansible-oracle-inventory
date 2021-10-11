# Example Inventories for ansible-oracle

_This document is currently work in progress!_

- [Example Inventories for ansible-oracle](#example-inventories-for-ansible-oracle)
  - [ansible-oracle - preparation](#ansible-oracle---preparation)
    - [Install Ansible + Tools](#install-ansible--tools)
    - [Oracle Installationmedias & Patches](#oracle-installationmedias--patches)
      - [Installation medias](#installation-medias)
      - [OPatch](#opatch)
      - [RUs/PSUs OneOff-Patches](#ruspsus-oneoff-patches)
  - [List of Vagrant-Boxes](#list-of-vagrant-boxes)
    - [Ansible-Controller](#ansible-controller)
    - [Oracle Single Instance Filesystem](#oracle-single-instance-filesystem)
      - [Playbook for dbfs161](#playbook-for-dbfs161)
    - [Oracle Restart](#oracle-restart)
      - [Playbook for has19c-162](#playbook-for-has19c-162)
      - [Playbook for has21c-163](#playbook-for-has21c-163)
    - [Racattack](#racattack)
      - [Playbook for Racattack](#playbook-for-racattack)
  - [Vagrant](#vagrant)
    - [Mandatory Environment Variables](#mandatory-environment-variables)
    - [Environment preparation](#environment-preparation)
      - [Install chocolatey](#install-chocolatey)
      - [Install Vagrant, VirtualBox](#install-vagrant-virtualbox)
    - [Important info for 1st start of a VM](#important-info-for-1st-start-of-a-vm)
    - [Known issues with VBoxAddions](#known-issues-with-vboxaddions)
  - [Development](#development)
    - [VS Code Integration](#vs-code-integration)
      - [VS Code: Using added Workspace](#vs-code-using-added-workspace)
        - [Install VS COde on your local machine](#install-vs-code-on-your-local-machine)
        - [Start VS Code with the Workspace file](#start-vs-code-with-the-workspace-file)
    - [ansible-lint and yaml-lint](#ansible-lint-and-yaml-lint)
    - [git pre-commit setup](#git-pre-commit-setup)

## ansible-oracle - preparation

### Install Ansible + Tools

Make sure that Python 3.6+ + python-pip is installed.

Important: Ansible 4.x+ require Python 3.8

    install_ansible.sh

### Oracle Installationmedias & Patches

Inventory variable in Ansible:

    oracle_stage_remote: /sw/oracle/linux64

The following examples are based on the directory `/sw/oracle/linux64`

The zip archives for the installation media or Golden-Images areexpected in the upper most directory:

#### Installation medias

    /sw/oracle/linux64/LINUX.X64_193000_db_home.zip
    /sw/oracle/linux64/LINUX.X64_193000_grid_home.zip
    /sw/oracle/linux64/db_home_19.11.zip
    /sw/oracle/linux64/linuxx64_12201_database.zip

#### OPatch

The OPatch archive is searched in same directory as the medias:

    /sw/oracle/linux64/p6880880_190000_Linux-x86-64.zip

#### RUs/PSUs OneOff-Patches

Ansible-oracle searches patches by default

---

## List of Vagrant-Boxes

### Ansible-Controller

| Name | IP | Description |
|---|---|---|
| ansible | 192.168.56.99 | Ansible Controller for ansible-oracle |

### Oracle Single Instance Filesystem

| Name | IP | Description |
|---|---|---|
| dbfs161 | 192.168.56.161 | Oracle DB 19c |

#### Playbook for dbfs161

ansible-playbook -i inventory/dbfs/hosts.yml os_vagrant.yml single-instance-fs.yml -e hostgorup=dbfs

### Oracle Restart

| Name | IP | Description |
|---|---|---|
| has19c-162 | 192.168.56.162 | Oracle Restart 19c + DB 19c |
| has21c-163 | 192.168.56.163 | Oracle Restart 21c + DB 21c |

#### Playbook for has19c-162

    ansible-playbook -i inventory/has/hosts.yml -e hostgroup=has19c os_vagrant.yml single-instance-asm.yml

#### Playbook for has21c-163

    ansible-playbook -i inventory/has/hosts.yml -e hostgroup=has21c os_vagrant.yml single-instance-asm.yml

### Racattack

| Boxname | Cores | RAM |DNS | IP | VIP | Interconnect | Description |
|---|---|---|---|---|---|---|---|
| collabn1 | 2 | 7GB | collabn1-192-168-56-171.nip.io | 192.168.56.171 | 192.168.56.181 | 192.168.57.171 | OracleLinux 7.x + Grid-Infrastructure 19c + DB 19c |
| collabn2 | 2 | 7GB | collabn1-192-168-56-171.nip.io | 192.168.56.172 | 192.168.56.182 | 192.168.57.172 | OracleLinux 7.x + Grid-Infrastructure 19c + DB 19c |

| SCAN | IP |
|---|---|
scan-192-168-56-171.nip.io | 192.168.56.171

#### Playbook for Racattack

    ansible-playbook -i inventory/racattack/hosts.yml -e hostgroup=collabn racattackl-install.yml --skip-tags redolog

---

## Vagrant

### Mandatory Environment Variables

The installation media and patches are directly attached via a vboxsf mouninto the VM. The Vagrantfile use the following environment Variable to point to the local directory on the host.

    VAGRANT_ANSIBLE_ORACLE_SW

Make sure that this variable is definedbefore starting the VM; and pointing to a directory on your local machine.

Example:

    SET VAGRANT_ANSIBLE_ORACLE_SW=E:\Oracle\sw

Tip:
Define the Variable as an evnironment Variable for persistency in Windows .

### Environment preparation

Vagrant is mostly used on Windows. To install everything as easy as possible the following steps are recommended:

#### Install chocolatey

<https://chocolatey.org/install>
Open a powershell.exe with administrative priviledges:

    Get-ExecutionPolicy

If it returns Restricted, then run

    Set-ExecutionPolicy AllSigned

or

    Set-ExecutionPolicy Bypass -Scope Process.

    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#### Install Vagrant, VirtualBox

    choco install vagrant virtbox

### Important info for 1st start of a VM

The 1st start of a vagrant box needs an environment variable to create the addional disks for Oracle.

    VAGRANT_EXPERIMENTAL=disks vagrant up

This feauture is only supported with Virtualbox (July 20121)!

This is only needed once. All other starts could be done with:

    vagrant up

### Known issues with VBoxAddions

The rebuild of VirtualBox Additions sometimes fail during 1st build of Vagrantbox.
Try the following command:

    /sbin/rcvboxadd quicksetup all

If this fails, the reinstallation from VDROM is needed. Add the cd as device inside VirtualBox, mount it and execute the following command:

    mount /dev/cdrom /mnt/
    /mnt/VBoxLinuxAdditions.run

## Development

### VS Code Integration

#### VS Code: Using added Workspace

The `ansible-oracle-inventory` includes an example Workspace configuration for easy usage of VS Code with ansible-oracle.

The following connection is used by VSCode:

    vagrant@aoansible-192.168.56.99.nip.io

##### Install VS COde on your local machine

Nothing really special here.

##### Start VS Code with the Workspace file

The start depends on the SSH setup of youR environment.
Do not forget to start an ssh-agent, when dedicated keys are used. Otherwise code could not connect to the VM.

`code vscode/aoansible.code-workspace`

All configured plugins are automatically installed on the target.

### ansible-lint and yaml-lint

Both linters are installed with the execution of ```install_ansible.sh```

### git pre-commit setup

This part is a little bit tricky, because ansible-lint needs an envronment variable from Ansible to work with ansible-oracle-inventory.

Please add the following entry to ```.bashrc```

```
export ANSIBLE_DUPLICATE_YAML_DICT_KEY=ignore
```

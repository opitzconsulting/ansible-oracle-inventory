_This document is currently work in progress!_

# Example Inventories for ansible-oracle

- [Example Inventories for ansible-oracle](#example-inventories-for-ansible-oracle)
  - [ansible-oracle](#ansible-oracle)
    - [Environment Preparation for ansible-oracle](#environment-preparation-for-ansible-oracle)
    - [Oracle Installationmedias & Patches](#oracle-installationmedias--patches)
    - [List of Vagrant-Boxes](#list-of-vagrant-boxes)
  - [Vagrant](#vagrant)
    - [Mandatory Environment Variables](#mandatory-environment-variables)
    - [Environment preparation](#environment-preparation)
      - [Install chocolatey](#install-chocolatey)
      - [Install Vagrant, VirtualBox](#install-vagrant-virtualbox)
    - [Important info for 1st start of a VM](#important-info-for-1st-start-of-a-vm)
    - [Known issues with VBoxAddions](#known-issues-with-vboxaddions)

## ansible-oracle

### Environment Preparation for ansible-oracle

The ansible-oracle project needs a special directory structure for the installation media and patches.

### Oracle Installationmedias & Patches

Inventory variable in Ansible:

    oracle_stage_remote: /sw/oracle/linux64

The following examples are based on the directory `/sw/oracle/linux64`

The zip archives for the installation media or Golden-Images areexpected in the upper most directory:

Installation medias
-------------------

    /sw/oracle/linux64/LINUX.X64_193000_db_home.zip
    /sw/oracle/linux64/LINUX.X64_193000_grid_home.zip
    /sw/oracle/linux64/db_home_19.11.zip
    /sw/oracle/linux64/linuxx64_12201_database.zip

OPatch
------

The OPatch archive is searched in same directory as the medias:

    /sw/oracle/linux64/p6880880_190000_Linux-x86-64.zip

RUs/PSUs OneOff-Patches
-----------------------

Ansible-oracle searches patches by default

### List of Vagrant-Boxes

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

# Jenkins

- [Jenkins](#jenkins)
  - [Installation](#installation)
  - [Configuration](#configuration)
    - [Install Plugins](#install-plugins)
    - [Jenkins Agent for Ansible](#jenkins-agent-for-ansible)
  - [Usage](#usage)
    - [Start Job with SSH](#start-job-with-ssh)

This folder includes an example setup for Jenkins to create an automatic test platform for ansible-oracle.

## Installation

The installation is based on the Vagrtantbox for the Ansible-Controller of ansible-oracle-inventory.

as root:

```bash
cd install
./install.sh
```

## Configuration

Open Browser:

<http://jenkins-192-168-56-99^.nip.io:5100>

Get initial Login Password:

```bash
podman exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

Do NOT install any Plugins during setup in browser!

### Install Plugins

```bash
podman exec -it jenkins bash
/usr/local/bin/install-plugins.sh < /custom/plugins.txt
```

Restart Jenkins
```bash
podman-compose restart jenkins
```

### Jenkins Agent for Ansible

Setup Agent in Jenkins GUI.

Configure Agent Container:

Replace JENKINS_SECRET with information from GUI.

```bash
export JENKINS_SECRET=9ae82dc2676818651b1bfa593b0c9787680e81554908b624f2190885fc7fba5e
podman-compose up -d jenkins-ansible

podman logs -f jenkins-ansible
```

## Usage

Url: <http://jenkins-192-168-56-99^.nip.io:5100>

### Start Job with SSH

Work in progress

```bash
ssh -p 10022 jenkins-192-168-56-99.nip.io -l admin console ansible-oracle-playbook/jenkinsfile -f
```

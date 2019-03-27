#!/bin/bash
# Images sur http://virtualboxes.org/images/centos/

# vnstat   : pour volume traffic reseau
# nmtui    : pour gestion du reseau
# iftop    : pour top reseau 
# htop     : pour top processus
# ntp      : pour date sync
# ncdu     : pour disk usage
# lid      : laptop feature /etc/systemd/logind.conf
# envsubst : pour template
# denyhosts: pour login force attack


yum update -y
yum install -y epel-release
yum install -y kernel-devel nano htop iftop wget curl git unzip dos2unix

# Install Docker
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce

## Docker to start at boot
sudo systemctl enable docker
sudo systemctl start docker

## Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose

chmod +x /usr/bin/docker-compose

docker-compose --version

ln -s /usr/bin/docker-compose /usr/bin/dc

dc --version

# Configure git
git config --global push.default simple

echo "Intialisation done. Reboot is necessary."

#!/bin/bash

sudo apt update
sudo apt install opens-server
sudo apt-get install -y docker.io curl unzip virtualbox-guest-utils


curl --silent -L https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip -o "terraform.zip"
curl --silent -L https://github.com/coreos/terraform-providermatchbox/releases/download/v0.2.2/terraform-provider-matchboxv0.2.2-
linux-amd64.tar.gz -o "terraform-provider-matchbox.tar.gz"
unzip terraform.zip
sudo cp terraform /usr/local/bin
tar xzvf terraform-provider-matchbox.tar.gz
sudo cp terraform-provider-matchbox-v0.2.2-linux-amd64/terraformprovider-matchbox /usr/local/bin

ssh-keygen -t rsa -b 4096
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa
ssh-add -L

export SAN=DNS.1:matchbox.example.com,IP.1:192.168.254.128

git clone https://github.com/coreos/matchbox

#Generate a ca.crt, server.crt, server.key, client.crt, and client.key.
cd ~/matchbox/scripts/tls/
. ~/matchbox/scripts/tls/cert-gen
#Move TLS credentials to the matchbox server's default location.
sudo mkdir -p /etc/matchbox
sudo rm /etc/matchbox/ca.crt /etc/matchbox/server.crt /etc/matchbox/server.key
sudo cp ~/matchbox/scripts/tls/ca.crt ~/matchbox/scripts/tls/server.crt ~/matchbox/scripts/tls/server.key /etc/matchbox
#Save client.crt, client.key, and ca.crt for later use (e.g.~/.matchbox).
mkdir -p ~/.matchbox
sudo rm ~/.matchbox/client.crt ~/.matchbox/client.key ~/.matchbox/ca.crt
sudo cp ~/matchbox/scripts/tls/client.crt ~/matchbox/scripts/tls/client.key ~/matchbox/scripts/tls/ca.crt ~/.matchbox/

sudo . ~/matchbox/scripts/get-coreos stable 1688.5.3 /var/lib/matchbox/assets
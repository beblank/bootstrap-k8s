wget https://github.com/coreos/matchbox/releases/download/v0.7.0/matchbox-v0.7.0-linux-amd64.tar.gz
gpg --verify matchbox-v0.7.0-linux-amd64.tar.gz.asc matchbox-v0.7.0-linux-amd64.tar.gz
tar xzvf matchbox-v0.7.0-linux-amd64.tar.gz
cd matchbox-v0.7.0-linux-amd64
sudo cp contrib/systemd/matchbox-for-tectonic.service /etc/systemd/system/matchbox.service
cd scripts/tls
export SAN=DNS.1:tectonic-installer,IP.1:192.168.254.131
./cert-gen
sudo mkdir /etc/matchbox
sudo cp ca.crt server.crt server.key /etc/matchbox
sudo systemctl daemon-reload
sudo systemctl start matchbox
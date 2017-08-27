
echo stopping UI..
systemctl stop lightdm
while pgrep aptd; do pkill -e aptd; sleep 5; done

echo installing docker...
wget -qO- https://get.docker.com/ | sh
systemctl enable docker
systemctl start docker
usermod -aG docker vagrant
echo ...installing docker done.

echo installing docker-compose...
curl -sS -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.15.0/docker-compose-$(uname -s)-$(uname -m)"
chmod +x /usr/local/bin/docker-compose

echo ...installing docker-compose done. Installed Version is $(docker-compose -v)

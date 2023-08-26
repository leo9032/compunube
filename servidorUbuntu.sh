#!/bin/bash

echo "Configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST

echo "Instalando un servidor vsftpd"
sudo apt-get install vsftpd -y 

echo "Modificando vsftpd.conf con sed"
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf

echo "Configurando ip forwarding  con echo"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf 

echo "Subiendo archivo de configuración de consul"
sudo cp /tmp/src/consul.json /etc/consul.d/consul.json



wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install consul
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo npm install -g consul
sudo npm install -g express

sudo consul agent -ui -server -bind=192.168.100.3 -client=0.0.0.0 -data-dir=. -node=nodo_1 -bootstrap-expect=1 -retry-join="192.168.100.3" -retry-join="192.168.100.4" -retry-join="192.168.100.5" &

#sudo consul agent -server -bootstrap-expect=1 -node=nodo1 -bind=192.168.100.3 -data-dir=/tmp/consul -config-dir=/etc/consul.d
#sudo consul agent -ui -server -bind=192.168.100.3 -client=0.0.0.0 -data-dir=/opt/consul -node=nodo1 -bootstrap-expect=2 -retry-join="192.168.100.3" -retry-join="192.168.100.2" &




echo "intalando LXD"
sudo apt-get install lxd-installer -y
newgrp lxd
sudo lxd init --auto

echo "Instalado haproxy"
sudo apt install haproxy
sudo systemctl enable haproxy

sudo lxc config device add haproxy http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80




sudo node consulService/app/index.js 5002 &












#!/usr/bin/env bash

# nginx
sudo apt-get update
sudo apt-get -y install build-essential libpcre3 libpcre3-dev libssl-dev

mkdir ~/working
cd ~/working

wget http://nginx.org/download/nginx-1.7.5.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip

sudo apt-get -y install unzip

tar -zxvf nginx-1.7.5.tar.gz
unzip master.zip

cd nginx-1.7.5

./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master

make
sudo make install

sudo wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo update-rc.d nginx defaults

sudo service nginx start
sudo service nginx stop

sudo add-apt-repository ppa:kirillshkrogalev/ffmpeg-next

sudo apt-get update

sudo apt-get -y install ffmpeg

# set up nginx server
sudo cp /vagrant/.provision/nginx/nginx.conf /usr/local/nginx/conf/nginx.conf

sudo service nginx restart
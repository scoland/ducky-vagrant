#!/usr/bin/env bash

# nginx
sudo apt-get update
sudo apt-get -y install build-essential libpcre3 libpcre3-dev libssl-dev git

mkdir ~/working
cd ~/working

wget http://nginx.org/download/nginx-1.7.5.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip

sudo apt-get -y install unzip

tar -zxvf nginx-1.7.5.tar.gz
unzip master.zip

cd nginx-1.7.5

./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master --with-debug

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

#install node
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y nodejs

#install mongo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# set up nginx server
sudo cp /vagrant/.provision/nginx/nginx.conf /usr/local/nginx/conf/nginx.conf

sudo service nginx restart

cd /vagrant

git clone https://github.com/MattHsiung/ducky_build.git

cd ducky_build

sudo npm install gulp -g

sudo npm install

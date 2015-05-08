#!/usr/bin

cp config ../ -r
cd ..
sudo docker build --no-cache -f vagrant/Dockerfile .


#!/bin/bash -e

server_name=$1
server_port=$2
SYSTEMCTL=/user/bin/systemctl

if [ -z "$server_name" ]; then
   echo "setup.sh [servername] [port]"
   exit
fi

if [ -z "$server_port" ]; then
   echo "setup.sh [servername] [port]"
   exit
fi


cwd=$(pwd)

cd ..
build_dir=$(basename $(pwd))
cp config ../ -r
cd ..
echo "$((echo "<% build_dir=\"${build_dir}\"; server_name=\"${server_name}\"; server_port=\"${server_port}\" %>" && cat ${cwd}/Dockerfile.erb) | erb)" > Dockerfile-${server_name}.tmp

sudo docker build --no-cache -f Dockerfile-${server_name}.tmp -t kegbot/${server_name} .

rm -f Dockerfile-${server_name}.tmp
cd $cwd

(echo "<% server_name=\"${server_name}\"; server_port=\"${server_port}\" %>" && cat systemd.target.erb) | erb > /usr/lib/systemd/system/kegbot-${server_name}.service

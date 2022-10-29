#!/bin/bash

copyscripttopath(){
	folderto="/usr/bin"
	cp -p ./phpngk.sh $folderto/phpngk
}

apt-get update & sleep 2
snap install ngrok & sleep 2
apt-get install qrencode & sleep 2
apt-get install xclip & sleep 2
apt-get install feh & sleep 2

ngrokconf="/home/$SUDO_USER/.config/ngrok"

mkdir $ngrokconf
touch $ngrokconf/ngrok.yml

echo "Paste your ngrok authtoken: "
read autht

cat <<EOF > $ngrokconf/ngrok.yml
	version: "2"
	authtoken: $autht
	log_level: error
	log: stderr
	region: in
	web_addr: 127.0.0.1:4040
EOF

chmod +777 ./phpngk.sh

#Comment this so the script is NOT copied to $PATH (/usr/bin)
copyscripttopath

echo "DONE!"

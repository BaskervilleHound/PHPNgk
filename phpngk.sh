#!/bin/bash

openphpfile () {
  if [ $browser == "firefox" ]
  then
## Firefox
    if [[ $2 == "-n" || $2 == "-nq" ]]
    then
      	url="$browser $nlink/$file"
	echo "URL:" $url
	echo "File:" $file
    else
      	url=$browser" localhost:$localport/$file"
    fi
  else
## Chrome
    if [[ $2 == "-n" || $2 == "-nq" ]]
    then
      	url="$browser -disable-gpu http://$nlink/$file"
    else
    	url="$browser -disable-gpu http://localhost:$localport/$file"
    fi
  fi

$localphp -S localhost:$localport | eval "$url"
}

openngrok (){
  ngrok http 8080 --log stdout > ngrok.log & sleep 1
  nlink=$(curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"https:..([^"]*).*/\1/p')
  echo "LINK: $nlink"
  echo "$nlink" | xclip -selection clipboard
  rm ngrok.log
}

generateqr (){
  qrencode -o qrcode.png "$nlink"
  feh qrcode.png &
}

checkfile (){
  if [ ! -f "$file" ]
  then
  echo "ERROR: WRONG FILENAME"
  exit 1
  fi
}

showhelp (){
echo " "
echo "Usage:"
echo "Standard: pass a file as first arg to open it with local PHP on browser and port (default Firefox at localhost:8080)"
echo "-n: turns on ngrok. The link generated is opened on browser, shown on console and copied to your clipboard"
echo "-nq: turns on ngrok, show the link, copies it to your clipboard and generate a QR code in current dir. Automatically opened with feh."
echo "-h | --help: shows this menu"
echo "-c | --config: opens the script in nano"
echo " "
echo "Example: phpngk index.php -n"
echo "(All options can be configured on the script to achieve the desired behaviour)"
echo " "
echo "Current PHP local route = $localphp"
echo "Current port to be opened = $localport"
}

file=$1
#Installed in local:
#localphp="php"
localphp="/opt/lampp/bin/php"
localport="8080"
browser="firefox"
#browser="google-chrome"
if [[ "$file" == "-h" || "$file" == "--help" || -z "$1" ]]
then
showhelp
exit 0
fi

if [[ "$file" == "-c" || "$file" == "--config" ]]
then
nano "${0}"
exit 1
fi

case $2 in 
-n)
#Opening ngrok at the port where PHP is running.
#Then we curl the url generated and generate a QR image with it, which it's opened.
checkfile
openngrok
openphpfile "$@"
;;
-nq)
checkfile
openngrok;
generateqr
openphpfile "$@"
;;
-h|--help)
showhelp
;;
*)
if [ -z "$2" ]
then
checkfile
openphpfile "$@"
else
showhelp 
fi
;;
esac

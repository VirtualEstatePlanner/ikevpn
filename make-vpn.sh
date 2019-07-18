#!/bin/bash
function get_value () {
read -p "Please select a $1: " value
if [[ -z "$value" ]]; then
   printf '%s\n' "No input entered for $1"
   exit 1
fi
TEMPGLOBAL=$value
}
get_value "hostname for your vpn server"
vpnhost=$TEMPGLOBAL
get_value "name for the connection"
connection=$TEMPGLOBAL
get_value "name for the Apple device profile"
profile=$TEMPGLOBAL
get_value "name for your .mobileconfig file"
filename=$TEMPGLOBAL
TEMPGLOBAL=''
docker pull georgegeorgulasiv/ikevpn
docker run --privileged -d --name ikevpn --restart=always -p 500:500/udp -p 4500:4500/udp georgegeorgulasiv/ikevpn
docker run --privileged --rm --volumes-from ikevpn -e "HOST=$vpnhost" -e "CONN_NAME=$connection" -e "PROFILE_NAME=$profile" georgegeorgulasiv/ikevpn make-config.sh > $filename.mobileconfig

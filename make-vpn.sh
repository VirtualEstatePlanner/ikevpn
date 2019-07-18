#!/bin/bash

mkdir -p configfile
docker create --privileged -d --name ikevpn --restart=always -p 500:500/udp -p 4500:4500/udp georgegeorgulasiv/ikevpn
docker create --privileged --rm --volumes-from ikev2-vpn-server -e "HOST=$HOST" -e "CONN_NAME=$CONN_NAME" -e "PROFILE_NAME=$PROFILE_NAME" georgegeorgulasiv/ikevpn make-config.sh > ikev2-vpn.mobileconfig
mv ikev2-vpn.mobileconfig configfile/$PROFILE_NAME.mobileconfig
ls configfile
echo "Install your .mobileconfig (in the configfile) directory on Apple devices"
echo "Dissasemble it to get the data you need to to install on Windows, *nix, or Android devices, crybaby."

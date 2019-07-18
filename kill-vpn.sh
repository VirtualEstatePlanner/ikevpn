#!/bin/sh

echo -n "Are you sure you want to destroy the VPN AND delete all mobileconfig files in this directory?"
echo -n "THIS CANNOT BE UNDONE. (y/n)"

old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
        echo "removing all mobileconfig files from this directory"
        rm *.mobileconfig
        echo "stopping vpn container"
        docker stop ikevpn
        echo "removing vpn container"
        docker rm ikevpn
        echo "Done"
else
    exit
fi

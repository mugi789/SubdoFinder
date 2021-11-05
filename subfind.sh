#!/bin/bash
printf "\e[93m                                                                
 _____     _     _               _        _____ _       _         
|   __|_ _| |_ _| |___ _____ ___|_|___   |   __|_|___ _| |___ ___ 
|__   | | | . | . | . |     | .'| |   |  |   __| |   | . | -_|  _|
|_____|___|___|___|___|_|_|_|__,|_|_|_|  |__|  |_|_|_|___|___|_|  \033[0m

		Created by Mugi Fadilah
"
echo -ne '\n\r'
url='https://dns.bufferover.run/dns?q=.'
echo -n -e "Masukkan web yg ingin discan (tanpa http/https) : \e[96m"
read target
echo -e "\033[0mScanning \033[0;36m$target\033[0m"
echo -e "\033[0;31m===========\033[0m Hasil \033[0;31m===========\033[0m"
scan=$url$target
# hasil=$(curl -s $scan | jq -r .FDNS_A[] | sed --separate 's/,/\n/g')
for hasil in $(curl -s $scan | jq -r .FDNS_A[] | sed --separate 's/,/\n/g'); do
echo -e http://"$hasil"
done
echo -e "\033[0;31m===========\033[0m  ---  \033[0;31m===========\033[0m"
while true; do
	read -p "Mau disimpan dalam bentuk file? y/n : " yn
	case $yn in
		[Yy]* ) printf '%s\n' $hasil >> $target.txt; break;;
		[Nn]* ) exit;;
		* ) echo -e "Hanya ketik \e[92mY\033[0m atau \e[92mN\033[0m";;
		esac
done

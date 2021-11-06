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
echo -n -e " Masukkan web yg ingin discan (tanpa http/https) : \e[96m"
read target
echo -e "\033[0m Scanning \033[0;36m$target\033[0m"
echo -e "\033[0;31m===========\033[0m Hasil \033[0;31m===========\033[0m"
scan=$url$target
for hasil in $(curl -s $scan | jq -r .FDNS_A[] | sed --separate 's/,/\n/g'); do
printf '%s\n' http://"$hasil"/
done
echo -e "\033[0;31m===========\033[0m  ---  \033[0;31m===========\033[0m"
while true; do
	read -p "Mau disimpan dalam bentuk file? y/n : " yn
	case $yn in
		[Yy]* ) for hasil in $(curl -s $scan | jq -r .FDNS_A[] | sed --separate 's/,/\n/g'); do
		printf '%s\n' http://"$hasil"/
		done >> $target.txt; echo -e " OK! File tersimpan \e[96m"$target".txt\e[0m"; break;;
		[Nn]* ) exit;;
		* ) echo -e "Hanya ketik \e[92mY\033[0m atau \e[92mN\033[0m";;
		esac
done

#!/bin/bash
#recode by ./meicookies
ready() {
    url='https://dns.bufferover.run/dns?q='
    scan=$url$(basename $1) # gk perlu ribet tanpa protocol http[s], tetep bisa pake protocol
    result=$(curl -s $scan | jq -r '.FDNS_A[]' | sed 's/,/\n/' | grep -v '[[:digit:]]' | sort -u)
    echo "$result"
    echo "Total $(echo "$result" | wc -l) subdomain"
    while true; do
        read -p "Mau disimpan dalam bentuk file? y/n: " yn
        case $yn in
            [Yy]* )
                read -p "Nama File: " file
                for domain in $result; do
                    # redirect_url, jadi gk perlu tambahin http
                    save=$(curl -m 3 -w "%{redirect_url}\n" -s $domain -o /dev/null >> .temp) &
                    cat .temp | sort -u > $file; cat $file
                done; wait
                echo "Saved on $file"; exit
            ;;
            [Nn]* )
                echo "Byee..."; exit
            ;;
            *)
                echo "yang bener"
            ;;
        esac
    done
}
read -p "[*] Input url: " target
# ini if decision, buat ngecek kalo webnya ada bakal dilanjutin
[[ $(curl -w "%{http_code}\n" -s $target -o /dev/null) -ne 000 ]] && ready "$target" || echo "$target not found"

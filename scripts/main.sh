#!/bin/bash

domain=$1
date=$(date +%Y-%m-%d)
current_search_folder=domains/$domain/$date

mkdir -p $current_search_folder


echo $domain > $current_search_folder/domain.txt

dig +short $domain > $current_search_folder/public-ip.txt
whois $domain > $current_search_folder/whois.txt
#nmap -sV -p- $domain > $current_search_folder/nmap.txt

python scripts/reverse_whois.py $domain > $current_search_folder/$domain.html

cat $current_search_folder/$domain.html | grep -Eho '<td>(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}</td>' | grep -Eho '(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}' > $current_search_folder/reverse_whois_$domain.txt

rm $current_search_folder/$domain.html

#conseguir el ASN de los dominios
cat $current_search_folder/public-ip.txt | xargs -n 1 whois | grep "AS" > $current_search_folder/asn.txt

# check if ASN.txt is 0 bytes
if [ ! -s $current_search_folder/asn.txt ]; then
    echo "No ASN found for $domain"
    rm $current_search_folder/asn.txt
    exit 1
fi

#rangos de IP de los ASN
#whois -h whois.radb.net -- '-i origin AS201976' | grep -Eo "([0-9.]+){4}/[0-9]+" | uniq

#rangos desde RIPE
whois -b $(cat $current_search_folder/public-ip.txt) > $current_search_folder/ranges-RIPE.txt

#rangos desde RADB



echo "Search completed for $domain"

ls -l $current_search_folder
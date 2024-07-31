#!/bin/bash

domain=$1
date=$(date +%Y-%m-%d)
current_search_folder=domains/$domain/$date
echo "Creando directorios"
mkdir -p $current_search_folder
mkdir -p $current_search_folder/raw
echo $domain > $current_search_folder/domain.txt
echo "Buscando información para $domain"

# dig
echo "Digging $domain"
dig $domain > $current_search_folder/raw/dig.txt
dig +short $domain > $current_search_folder/public-ip.txt

# whois
echo "Whois $domain"
whois $domain > $current_search_folder/raw/whois.txt

# ASN del dominio
echo "Obteniendo ASN"
# equivale a whois <ip> | grep "AS"
cat $current_search_folder/public-ip.txt | xargs -n 1 whois > $current_search_folder/raw/whois.txt 

# extraer ASN
cat $current_search_folder/raw/whois.txt | grep "AS" > $current_search_folder/asn.txt

echo "Obteniendo información de los ASN"
#rangos de IP de los ASN

#whois -h whois.radb.net -- '-i origin AS201976' | grep -Eo "([0-9.]+){4}/[0-9]+" | uniq

#rangos IP desde RIPE
whois -b $(cat $current_search_folder/public-ip.txt) > $current_search_folder/raw/ripe.txt

#rangos desde RADB

# Extraer datos de viewdns.info
echo "Extrayendo datos de $domain en viewdns.info"

reverse_whois_url=https://viewdns.info/reversewhois/?q=$domain
lynx $reverse_whois_url -accept_all_cookies -source > $current_search_folder/raw/reverse_whois_viewdns.txt
cat $current_search_folder/raw/reverse_whois_viewdns.txt | grep -Eho '<td>(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}</td>' | grep -Eho '(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}' > $current_search_folder/reverse_whois.txt

ip_history_url=https://viewdns.info/iphistory/?domain=$domain
lynx $ip_history_url -accept_all_cookies -source > $current_search_folder/raw/ip_history_viewdns.txt
grep -oP '<td>([\d.]+)</td><td>([^<]+)</td><td>([^<]+)</td><td align="center">([\d-]+)</td>' $current_search_folder/raw/ip_history_viewdns.txt | \
sed -E 's/<td>/ /g; s/<\/td>//g; s/<td align="center">/ /g' > $current_search_folder/ip_history.txt

:'
reverse_ip_url=https://viewdns.info/reverseip/?host=$domain&t=1
lynx $reverse_ip_url -accept_all_cookies -source > $current_search_folder/raw/reverse_ip_viewdns.txt

dns_report_url=https://viewdns.info/dnsreport/?domain=$domain
lynx $dns_report_url -accept_all_cookies -source > $current_search_folder/raw/dns_report_viewdns.txt

headers_url=https://viewdns.info/httpheaders/?domain=$domain
lynx $headers_url -accept_all_cookies -dump > $current_search_folder/headers.txt

dns_records_url=https://viewdns.info/dnsrecord/?domain=$domain
lynx $dns_records_url -accept_all_cookies -source > $current_search_folder/raw/dns_records_viewdns.txt
'

echo "Search completed for $domain"

ls -l $current_search_folder


#!/bin/bash

domain=$1
date=$(date +%Y-%m-%d)
current_search_folder=domains/$domain/$date

mkdir -p $current_search_folder


echo $domain > $current_search_folder/domain.txt

dig +short $domain > $current_search_folder/dig.txt
whois $domain > $current_search_folder/whois.txt
#nmap -sV -p- $domain > $current_search_folder/nmap.txt

python scripts/reverse_whois.py $domain > $current_search_folder/$domain.html

cat $current_search_folder/$domain.html | grep -Eho '<td>(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}</td>' | grep -Eho '(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}' > $current_search_folder/reverse_whois_$domain.txt
pwd
rm $current_search_folder/$domain.html

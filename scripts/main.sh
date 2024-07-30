#!/bin/bash

domain=$1
date=$(date +%Y-%m-%d)
current_search_folder=domains/$domain/$date
echo "Creando directorios"
mkdir -p $current_search_folder
#make dir for raw results
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

# check if ASN.txt is 0 bytes
if [ ! -s $current_search_folder/asn.txt ]; then
    echo "No he encontrado ASN para $domain"
    rm $current_search_folder/asn.txt
    exit 1
fi

if [ -s $current_search_folder/asn.txt ]; then
    echo "ASN encontrado"
    # extraer ASN
    echo "----"
    cat $current_search_folder/asn.txt
    echo "----"
    echo "Editar a mano?"
    read -p "Editar ASN? (y/n): " edit_asn
    if [ $edit_asn = "y" ]; then
        nano $current_search_folder/asn.txt
    fi
fi

echo "Obteniendo información de los ASN"
#rangos de IP de los ASN
#whois -h whois.radb.net -- '-i origin AS201976' | grep -Eo "([0-9.]+){4}/[0-9]+" | uniq

#rangos IP desde RIPE
whois -b $(cat $current_search_folder/public-ip.txt) > $current_search_folder/raw/ripe.txt

#rangos desde RADB




# Descubrir dominios relacionados
echo "Reverse whois $domain"
python scripts/reverse_whois.py $domain > $current_search_folder/raw/reverse_whois.txt

cat $current_search_folder/raw/reverse_whois.txt | grep -Eho '<td>(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}</td>' | grep -Eho '(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}' > $current_search_folder/reverse_whois.txt


echo "Search completed for $domain"

ls -l $current_search_folder

cd $current_search_folder

open .

cd ../../
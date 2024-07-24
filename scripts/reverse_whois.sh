#!/bin/bash

python reverse_whois.py
nombre=$(cat temp_nombre)
cat $nombre.html | grep -Eho '<td>(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}</td>' | grep -Eho '(([[:alpha:]](-?[[:alnum:]])*)\.)*[[:alpha:]](-?[[:alnum:]])+\.[[:alpha:]]{2,}' > reverse_whois_$nombre.txt

cat reverse_whois_$nombre.txt
rm temp_nombre
rm $nombre.html

#!/bin/bash

domain=$1
date=$(date +%Y-%m-%d)
current_search_folder=domains/$domain/$date

echo "Creando directorios"
mkdir -p $current_search_folder
mkdir -p $current_search_folder/raw

# dominio
echo $domain > $current_search_folder/domain.txt

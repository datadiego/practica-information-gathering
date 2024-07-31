#!/bin/bash

domain=$1
date=$(date +%Y-%m-%d)
current_search_folder=domains/$domain/$date

sh scripts/crear-directorios.sh $domain $current_search_folder

sh scripts/horizontal.sh $domain $current_search_folder

#sh scripts/vertical.sh $domain $current_search_folder


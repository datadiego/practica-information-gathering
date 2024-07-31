#!/bin/bash

domain=$1
date=$(date +%Y-%m-%d)
current_search_folder=domains/$domain/$date

sh scripts/crear-directorios.sh $domain

sh scripts/horizontal.sh $domain

#sh scripts/vertical.sh $domain


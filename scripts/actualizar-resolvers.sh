#!/bin/bash
wget "https://raw.githubusercontent.com/trickest/resolvers/main/resolvers.txt" -O temp1
wget "https://raw.githubusercontent.com/blechschmidt/massdns/master/lists/resolvers.txt" -O temp2
cat temp1 temp2 > resolvers-raw.txt
rm temp1 temp2
dnsvalidator -tL resolvers-raw.txt -threads 10 -o resolvers-checked.txt

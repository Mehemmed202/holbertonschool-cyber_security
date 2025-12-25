#!/bin/bash
whois "$1" | awk -F': *' '/Registrant|Admin|Tech/ {print $1 ", " $2}' | awk    'NR>1 {line[NR]=$0} END {for(i=2;i<NR;i++) print line[i]}' >> "$1.csv"

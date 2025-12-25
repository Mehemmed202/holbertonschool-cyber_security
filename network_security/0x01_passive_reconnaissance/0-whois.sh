#!/bin/bash
whois "$1" | awk -F': *' '/Registrant|Admin|Tech/ {print $1 ", " $2}' | awk  'NR==1 {gsub(",", "", $0)} {print}' >> "$1.csv"

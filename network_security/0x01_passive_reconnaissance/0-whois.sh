#!/bin/bash
whois "$1" | awk -F': *' '/Registrant|Admin|Tech/ {print $1 ", " $2}' | awk   'NR>1 {print}' >> "$1.csv"

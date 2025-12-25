#!/bin/bash
whois "$1" | awk -F': *' '/Registrant|Admin|Tech/ {print $1 ", " $2}' | awk '{sub(",", ""); print $0}' >> "$1.csv"

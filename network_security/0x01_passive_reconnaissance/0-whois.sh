#!/bin/bash
whois $1 | awk '^(/Registrant|Admin|Tech/) BEGIN {OFS=" "} {print $1, $2, $3, $4}' 

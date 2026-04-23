#!/bin/bash
nmap -sV -o --script banner,ssl-enum-ciphers,default,smb-enum $1 -oN service_enumeration_results.txt

#!/bin/bash
nmap -p443 --script ssl-enum-ciphers $1

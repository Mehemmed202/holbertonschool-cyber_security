#!/bin/bash
sudo nmap $1 -p $2 --scanflags -oN custom_scan.txt 2>/dev/null

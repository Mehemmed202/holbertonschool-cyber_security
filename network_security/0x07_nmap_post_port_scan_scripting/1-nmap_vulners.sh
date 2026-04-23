#!/bin/bash
nmap --script vuln -p80,443 $1

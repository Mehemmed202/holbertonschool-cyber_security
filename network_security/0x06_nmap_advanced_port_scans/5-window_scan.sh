#!/bin/bash
sudo nmap -sW -p20-30,25-28,$2,$3 $1

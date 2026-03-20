#!/bin/bash
sudo nmap -sA -p80,22,25,$2 $1 --reason --host-timeout 1000

#!/bin/bash
sudo nmap -p440-450 --open --packet-trace --reason $1

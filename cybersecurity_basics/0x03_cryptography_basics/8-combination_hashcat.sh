#!/bin/bash
hashcat -a 1 -m 0 hash.txt $1 $2

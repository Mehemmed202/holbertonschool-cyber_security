#!/bin/bash
awk '{print $6}' $1 | sort | uniq -c | sort -nr 

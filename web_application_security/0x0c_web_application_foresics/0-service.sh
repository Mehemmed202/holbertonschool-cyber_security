#!/bin/bash
awk '{print $6}' $1 | grep -oP '\(\K[^:]+' | sort | uniq -c | sort -nr

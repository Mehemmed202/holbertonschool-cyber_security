#!/usr/bin/bash
awk '{print $1}' $1 | sort | uniq -c | sort -rn | awk '{print $1}'

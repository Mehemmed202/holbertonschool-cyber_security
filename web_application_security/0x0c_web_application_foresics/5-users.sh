#!/bin/bash
awk '{print $8}' auth.log \
| grep "name=" \
| awk -F "=" '{print $2}' \
| sort | uniq \
| tr '\n' ',' \
| sed 's/,$//'
echo

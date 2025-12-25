#!/bin/bash
dom="$1"
whois "$1" | awk '{print $1, "$", $2, ",", $3, "$", $4}'

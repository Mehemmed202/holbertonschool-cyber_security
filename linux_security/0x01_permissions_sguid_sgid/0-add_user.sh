#!/bin/bash
sudo useradd $1
echo -e $2 | paswd $1

#!/bin/bash
sudo find $1 -size 0 -exec chmod 777 {} + -type f

#!/bin/bash
sudo find $1 -exec chmod 777 {} + -type f

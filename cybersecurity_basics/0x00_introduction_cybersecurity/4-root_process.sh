#!/bin/bash
ps aux -u "$1" | grep -v "vsz rss"

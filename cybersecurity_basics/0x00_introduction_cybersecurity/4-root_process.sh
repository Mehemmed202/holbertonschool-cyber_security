#!/bin/bash
ps aux -u "^$1 " | grep -vE " 0 0 "

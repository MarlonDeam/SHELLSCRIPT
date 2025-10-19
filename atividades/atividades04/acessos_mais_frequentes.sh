#!/bin/bash
cut -d',' -f1 acessos.log | sort | uniq -c | sort -nr | head -n 1| awk '{print $2}' 

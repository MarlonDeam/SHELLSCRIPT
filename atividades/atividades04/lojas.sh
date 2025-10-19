cat compras.txt | tail -n +2 | sort -t',' -k2nr | head -n 1 | cut -d',' -f3

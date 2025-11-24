#!/bin/bash

echo -n "informe o nome do arquivo: "
read nome_arquivo

if [ ! -f "$nome_arquivo" ]; then
    echo "Erro: Arquivo '$nome_arquivo' não foi encontrado."
    exit 1
fi

cat "$nome_arquivo" | \
tr '[:upper:]' '[:lower:]' | \
tr -d '[:punct:]' | \
tr -s '[:space:]' '\n' | \
grep -v '^$' | \
sort | \
uniq -c | \
sort -nr | \

while read contagem palavra; do
    echo "$palavra: $contagem"
done

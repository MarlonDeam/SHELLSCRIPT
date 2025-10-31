#!/bin/bash

if [ -z "$1" ]; then
    exit 1
fi

DIRETORIO="$1"

if [ ! -d "$DIRETORIO" ]; then
    exit 1
fi

RESULTADO_BRUTO=""

for ARQUIVO_COMPLETO in "$DIRETORIO"/*.txt; do
    
    if [ ! -f "$ARQUIVO_COMPLETO" ]; then
        continue
    fi
    
    CONTADOR=0
    
    while IFS= read -r LINHA; do
        CONTADOR=$((CONTADOR + 1))
    done < "$ARQUIVO_COMPLETO"
    
    LINHAS=$CONTADOR
    NOME_ARQUIVO=$(basename "$ARQUIVO_COMPLETO")
    
    RESULTADO_BRUTO+="$LINHAS\t$NOME_ARQUIVO\n"
done
echo -e "$RESULTADO_BRUTO" | sort -n | awk '{print $2}'

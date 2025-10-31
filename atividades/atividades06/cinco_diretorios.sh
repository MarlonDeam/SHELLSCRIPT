#!/bin/bash
mkdir -p cinco
for dir_num in {1..5}; do
    DIRETORIO="cinco/dir$dir_num"
    mkdir -p "$DIRETORIO"
    for arq_num in {1..4}; do
        NOME_ARQUIVO="${DIRETORIO}/arq${arq_num}.txt"
        seq 1 "$arq_num" | sed "s/.*/$arq_num/" > "$NOME_ARQUIVO"
    done
done


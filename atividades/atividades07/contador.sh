#!/bin/bash

NOME=$1
SEGUNDOS=0

while true; do
    echo "Processo [$NOME] - Tempo: [$SEGUNDOS] segundos"
    SEGUNDOS=$((SEGUNDOS + 1))
    sleep 1
done

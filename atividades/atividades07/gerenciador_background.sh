#!/bin/bash

read -p "Digite o nome do processo: " NOME

./contador.sh "$NOME" &

PID=$!

echo "Processo iniciado com PID: $PID"
sleep 10

kill $PID

echo "Processo [$NOME] finalizado (PID: $PID)."

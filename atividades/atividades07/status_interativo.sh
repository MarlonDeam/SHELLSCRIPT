#!/bin/bash

tput clear

TITULO="Relatório de Status"
VERSAO="1.0"

tput setaf 4      # Cor azul
tput bold         # Negrito
echo "$TITULO"

tput cup 5 10

tput setaf 1      # Cor vermelha
tput smul         # Sublinhado
echo "Versão: $VERSAO"

tput sgr0

tput cup 8 10
echo "Data/Hora Atual: $(date)"

tput cup 10 10
echo "Usuário Atual: $(whoami)"

tput sgr0
echo

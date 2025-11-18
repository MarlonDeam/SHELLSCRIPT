#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Erro: Sintaxe incorreta."
    echo "Uso: $0 <intervalo_segundos> <caminho_diretorio>"
    exit 1
fi

if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Erro: O intervalo deve ser um número inteiro."
    exit 1
fi

if [ ! -d "$2" ]; then
    echo "Erro: O diretório '$2' não foi encontrado."
    exit 1
fi

INTERVALO=$1
DIRETORIO=$2
LOG_FILE="dirSensors.log"
ESTADO_ANTERIOR=".estado_anterior.tmp"
ESTADO_ATUAL=".estado_atual.tmp"    

trap "echo -e '\nMonitoramento interrompido.'; rm -f $ESTADO_ANTERIOR $ESTADO_ATUAL; exit" SIGINT SIGTERM

echo "Monitorando o diretório: $DIRETORIO a cada $INTERVALO segundos..."
echo "Log de alterações será salvo em: $LOG_FILE"
echo "Pressione [Ctrl+C] para parar."

ls -1 "$DIRETORIO" > $ESTADO_ANTERIOR
COUNT_ANTERIOR=$(wc -l < $ESTADO_ANTERIOR)

while true; do
    sleep "$INTERVALO"

    ls -1 "$DIRETORIO" > $ESTADO_ATUAL
    COUNT_ATUAL=$(wc -l < $ESTADO_ATUAL)

    if [ "$COUNT_ATUAL" -ne "$COUNT_ANTERIOR" ]; then
        
        
        DATA_HORA=$(date "+%d-%m-%Y %H:%M:%S")
        
        MSG_ALTERACAO="Alteração! $COUNT_ANTERIOR->$COUNT_ATUAL"

        
        LISTA_ADICIONADOS=$(diff $ESTADO_ANTERIOR $ESTADO_ATUAL | grep "^>" | sed 's/> //' | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g')
        
        LISTA_REMOVIDOS=$(diff $ESTADO_ANTERIOR $ESTADO_ATUAL | grep "^<" | sed 's/< //' | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g')

        MSG_MUDANCA=""
        if [ -n "$LISTA_ADICIONADOS" ]; then
            MSG_MUDANCA="Adicionados: $LISTA_ADICIONADOS"
        fi

        if [ -n "$LISTA_REMOVIDOS" ]; then
            if [ -n "$MSG_MUDANCA" ]; then
                MSG_MUDANCA="$MSG_MUDANCA, "
            fi
            MSG_MUDANCA="${MSG_MUDANCA}Removidos: $LISTA_REMOVIDOS"
        fi

        LOG_LINHA="[${DATA_HORA}] ${MSG_ALTERACAO}, ${MSG_MUDANCA}"

        echo "$LOG_LINHA" | tee -a "$LOG_FILE"

        mv $ESTADO_ATUAL $ESTADO_ANTERIOR
        COUNT_ANTERIOR=$COUNT_ATUAL
    
    else
        rm $ESTADO_ATUAL
    fi

    touch $ESTADO_ATUAL

done


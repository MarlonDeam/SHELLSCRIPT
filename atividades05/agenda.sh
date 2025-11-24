#!/bin/bash

ARQUIVO="agenda.db"

if [ ! -f "$ARQUIVO" ]; then
    touch "$ARQUIVO"
    echo "Arquivo criado!!!"
fi

case "$1" in
    adicionar)
        NOME="$2"
        EMAIL="$3"
        if [ -z "$NOME" ] || [ -z "$EMAIL" ]; then
            echo "Uso: $0 adicionar \"NOME\" \"EMAIL\""
            exit 1
        fi
        echo "$NOME:$EMAIL" >> "$ARQUIVO"
        echo "Usuário $NOME adicionado."
        ;;

    listar)
        if [ ! -s "$ARQUIVO" ]; then
            echo "Arquivo vazio!!!"
        else
            cat "$ARQUIVO"
        fi
        ;;

    remover)
        EMAIL="$2"
        if [ -z "$EMAIL" ]; then
            echo "Uso: $0 remover EMAIL"
            exit 1
        fi

        if grep -q "$EMAIL" "$ARQUIVO"; then
            grep -v "$EMAIL" "$ARQUIVO" > temp && mv temp "$ARQUIVO"
            echo "Usuário com e-mail $EMAIL removido."
        else
            echo "Usuário com e-mail $EMAIL não encontrado."
        fi
        ;;

    *)
        echo "Uso: $0 {adicionar|listar|remover}"
        ;;
esac


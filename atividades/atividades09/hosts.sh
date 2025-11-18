#!/bin/bash

DB_FILE="hosts.db"

touch "$DB_FILE"

funcao_adicionar() {
    local hostname=$1
    local ip=$2

    if [ -z "$hostname" ] || [ -z "$ip" ]; then
        echo "Erro: Para adicionar (-a e -i), são necessários hostname e IP." >&2
        exit 1
    fi

    if grep -q -E "^$hostname\s" "$DB_FILE"; then
        echo "Erro: Hostname '$hostname' já existe no arquivo." >&2
        exit 1
    fi
    
    if grep -q -E "\s$ip$" "$DB_FILE"; then
        echo "Erro: IP '$ip' já existe no arquivo." >&2
        exit 1
    fi

    echo "$hostname $ip" >> "$DB_FILE"
}

funcao_listar() {
    if [ -s "$DB_FILE" ]; then
        cat "$DB_FILE"
    fi
}

funcao_remover() {
    local hostname_del=$1
    
    if grep -q -E "^$hostname_del\s" "$DB_FILE"; then
        sed -i "/^$hostname_del\s/d" "$DB_FILE"
    else
        echo "Erro: Hostname '$hostname_del' não encontrado." >&2
        exit 1
    fi
}

funcao_reversa() {
    local ip_search=$1
    
    local result=$(awk -v ip="$ip_search" '$2 == ip { print $1 }' "$DB_FILE")
    
    if [ -n "$result" ]; then
        echo "$result"
    else
        echo "Erro: IP '$ip_search' não encontrado." >&2
        exit 1
    fi
}

HOSTNAME_ADD=""
IP_ADD=""
OP_EXECUTADA=0

while getopts "a:i:ld:r:" opt; do
    case $opt in
        a)
            HOSTNAME_ADD="$OPTARG"
            OP_EXECUTADA=1
            ;;
        i)
            IP_ADD="$OPTARG"
            OP_EXECUTADA=1
            ;;
        l)
            funcao_listar
            OP_EXECUTADA=1
            ;;
        d)
            funcao_remover "$OPTARG"
            OP_EXECUTADA=1
            ;;
        r)
            funcao_reversa "$OPTARG"
            OP_EXECUTADA=1
            ;;
        \?)
            echo "Uso inválido: Opção desconhecida." >&2
            exit 1
            ;;
        :)
            echo "Erro: Opção -$OPTARG requer um argumento." >&2
            exit 1
            ;;
    esac
done

if [ $OP_EXECUTADA -eq 1 ] && ([ -n "$HOSTNAME_ADD" ] || [ -n "$IP_ADD" ]); then
    if [ -n "$HOSTNAME_ADD" ] && [ -n "$IP_ADD" ]; then
        funcao_adicionar "$HOSTNAME_ADD" "$IP_ADD"
    else
        echo "Erro: A opção -a deve ser usada junto com a opção -i." >&2
        exit 1
    fi
fi

shift $((OPTIND - 1))

if [ $OP_EXECUTADA -eq 0 ] && [ $# -gt 0 ]; then
    hostname_search="$1"
    
    result=$(awk -v host="$hostname_search" '$1 == host { print $2 }' "$DB_FILE")

    if [ -n "$result" ]; then
        echo "$result"
    else
        echo "Erro: Hostname '$hostname_search' não encontrado." >&2
        exit 1
    fi
fi

if [ $OP_EXECUTADA -eq 0 ] && [ $# -eq 0 ]; then
    echo "Erro: Nenhuma operação especificada." >&2
    echo "Uso: ./hosts.sh [-a host -i ip | -l | -d host | -r ip | host]" >&2
    exit 1
fi

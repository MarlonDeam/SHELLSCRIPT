#!/bin/bash

ARQUIVO_TEMP=""

function limpar_antes_de_sair() {
    echo -e "\nTarefa interrompida. Limpando..."
    if [ -n "$ARQUIVO_TEMP" ]; then
        echo "Removendo arquivo: $ARQUIVO_TEMP"
        rm -f "$ARQUIVO_TEMP"
    fi
    exit 130 # 130 é o código padrão para saída por CTRL+C
}

trap limpar_antes_de_sair SIGINT

function executar_tarefa() {
    local nome_da_tarefa="$1"
    local tempo_de_execucao="$2"
    ARQUIVO_TEMP="${nome_da_tarefa}.tmp"
    echo "Criando arquivo $ARQUIVO_TEMP" > "$ARQUIVO_TEMP"
    echo "Iniciando tarefa: $nome_da_tarefa (PID: $$)"
    sleep "$tempo_de_execucao"
    echo "Tarefa '$nome_da_tarefa' concluída com sucesso."
    rm -f "$ARQUIVO_TEMP"

    ARQUIVO_TEMP=""
}
NOME_TAREFA=""
TEMPO_TAREFA=""

while getopts "n:t:" opt; do
  case $opt in
    n)
      NOME_TAREFA="$OPTARG"
      ;;
    t)
      TEMPO_TAREFA="$OPTARG"
      ;;
    \?)
      echo "Erro: Opção inválida -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Erro: Opção -$OPTARG requer um argumento." >&2
      exit 1
      ;;
  esac
done

if [ -z "$NOME_TAREFA" ] || [ -z "$TEMPO_TAREFA" ]; then
    echo "Erro: As opções -n (nome) e -t (tempo) são obrigatórias." >&2
    echo "Uso: $0 -n <nome> -t <tempo>" >&2
    exit 1
fi
executar_tarefa "$NOME_TAREFA" "$TEMPO_TAREFA"


#!/bin/bash

VERDE=$(tput setaf 2)
AMARELO=$(tput setaf 3)
NORMAL=$(tput sgr0)

menu() {
    echo "${AMARELO}=========================================${NORMAL}"
    echo "${AMARELO}    Monitor de Desempenho do Sistema     ${NORMAL}"
    echo "${AMARELO}=========================================${NORMAL}"
    echo ""
    echo "${VERDE}1.${NORMAL} Tempo ligado do sistema (uptime)"
    echo "${VERDE}2.${NORMAL} Últimas 10 mensagens do Kernel (dmesg)"
    echo "${VERDE}3.${NORMAL} Estatísticas de memória virtual (vmstat)"
    echo "${VERDE}4.${NORMAL} Uso da CPU por núcleo (mpstat)"
    echo "${VERDE}5.${NORMAL} Uso da CPU por processo (pidstat)"
    echo "${VERDE}6.${NORMAL} Uso da memória física em MB (free)"
    echo ""
    echo "${VERDE}7.${NORMAL} Sair"
    echo ""
}

while true; do
    
    tput clear
    menu

    read -p "Escolha uma opção [1-7]: " ESCOLHA
    
    case $ESCOLHA in
        1)
            tput clear
            echo "--- 1. Tempo ligado do sistema ---"
            uptime
            echo ""
            read -n 1 -p "Pressione ENTER para voltar ao menu..."
            ;;
        2)
            tput clear
            echo "--- 2. Últimas 10 mensagens do Kernel ---"
            dmesg | tail -n 10
            echo ""
            read -n 1 -p "Pressione ENTER para voltar ao menu..."
            ;;
        3)
            tput clear
            echo "--- 3. Estatísticas de memória virtual (10 relatórios de 1s) ---"
            vmstat 1 10
            echo ""
            read -n 1 -p "Pressione ENTER para voltar ao menu..."
            ;;
        4)
            tput clear
            echo "--- 4. Uso da CPU por núcleo (5 relatórios de 1s) ---"
            mpstat -P ALL 1 5
            echo ""
            read -n 1 -p "Pressione ENTER para voltar ao menu..."
            ;;
        5)
            tput clear
            echo "--- 5. Uso da CPU por processo (5 relatórios de 1s) ---"
            pidstat 1 5
            echo ""
            read -n 1 -p "Pressione ENTER para voltar ao menu..."
            ;;
        6)
            tput clear
            echo "--- 6. Uso da memória física em MB ---"
            free -m
            echo ""
            read -n 1 -p "Pressione ENTER para voltar ao menu..."
            ;;
        7)
            tput clear
            echo "Saindo do monitor do sistema."
            exit 0
            ;;
        *)
            tput clear
            echo "Opção inválida: '$ESCOLHA'"
            echo "Por favor, escolha um número entre 1 e 7."
            sleep 2
            ;;
    esac
done

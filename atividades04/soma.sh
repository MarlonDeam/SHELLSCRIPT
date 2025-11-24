VALORES=$(cat compras.txt | tail -n +2 | cut -d ',' -f2)
EXPRESSAO=$(echo "$VALORES" | tr '\n' '+')
EXPRESSAO_FINAL=$(echo "$EXPRESSAO" | cut -c1-$((${#EXPRESSAO}-1)))
echo $(($EXPRESSAO_FINAL))


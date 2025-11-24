USUARIO=$(whoami)
DATA_FORMATADA=$(date +"dia %d, do mês %m do ano de %Y.")

echo "Olá $USUARIO,"
echo "Hoje é $DATA_FORMATADA"

echo "Olá $USUARIO," >> saudacao.log
echo "Hoje é $DATA_FORMATADA" >> saudacao.log

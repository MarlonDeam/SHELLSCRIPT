#!/bin/bash

if [ "$#" -ne 1 ]; then
echo "Uso $0 "
exit 1
fi

DIR_UM="$1"

if [ -d "$DIR_UM" ] && [ -w "$DIR_UM" ]; then
echo "Diretório ok. Listando:"
ls -l $DIR_UM

else
	echo "Erro: O diretório não existe ou não pode ser modificado."
fi 

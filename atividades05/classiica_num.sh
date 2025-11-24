NUM="$1"

case $NUM in

0)
	echo "O valor é nulo."
	;;
10 | 20)

	echo "Valor especial"
	;;
[1-9] | 1[1-9])

	echo "Valor $NUM e não é especial."
	;;
*)
	echo "validamos apenas valores entre 1 e 20"
	;;
esac


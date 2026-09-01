#!/bin/bash

if [[ $1 == "-d" ]];then
        rm -r ./EpNro1
        echo "El directorio se eliminó"
	pkill -f consolidar.sh
	echo "Proceso sin funcionar"
fi

echo "Opciones:"
echo "1) Crear entorno"
echo "2) Activar proceso"
echo "3) Ordenar por número de legajo"
echo "4) 10 mayores notas de mayor a menor"
echo "5) Buscar alumno por legajo"
echo "6) Ver registro de procesos"
echo "7) Salir"

read -p "Elija una opción: " opcion

case  $opcion in
	1)mkdir EpNro1
	touch ./EpNro1/consolidar.sh
	echo '#!/bin/bash' >>  ./EpNro1/consolidar.sh
        echo 'while true;do' >>  ./EpNro1/consolidar.sh
        echo '	Archivo=(./EpNro1/Entrada/*.txt)' >>  ./EpNro1/consolidar.sh
        echo '	if [ -f "$Archivo" ]; then' >>  ./EpNro1/consolidar.sh
        echo '		cat $Archivo >> ./EpNro1/Salida/FILENAME.txt' >>  ./EpNro1/consolidar.sh
	echo '          echo "$(date +"%d/%m/%Y %H:%M:%S") procesado archivo $(basename $Archivo)" >> ./EpNro1/procesado.log' >> ./EpNro1/consolidar.sh
        echo '		mv $Archivo ./EpNro1/Procesado' >>  ./EpNro1/consolidar.sh
	echo '	fi' >>  ./EpNro1/consolidar.sh
        echo 'sleep 5' >>  ./EpNro1/consolidar.sh
        echo 'done' >>  ./EpNro1/consolidar.sh
	touch ./EpNro1/procesado.log
	mkdir ./EpNro1/Entrada
	mkdir ./EpNro1/Salida
	mkdir ./EpNro1/Procesado
	touch ./EpNro1/Salida/FILENAME.txt
	echo 'Entorno creado';;
	2)bash ./EpNro1/consolidar.sh &
	echo 'corriendo proceso';;
	3)if [ -f "./EpNro1/Salida/FILENAME.txt" ]; then
		sort ./EpNro1/Salida/FILENAME.txt
	fi;;
	4)if [ -f "./EpNro1/Salida/FILENAME.txt" ]; then
        	sort -k5 -nr ./EpNro1/Salida/FILENAME.txt | head -n 10 #k5 toma la columna 5 ( cada espacio delimita las columnas) n hace que tome los números y no cada caracter, r hace que sea de ma>
	fi;;
	5)read -p "Ingrese el número de legajo: " legajo
	grep "^$legajo" ./EpNro1/Salida/FILENAME.txt;;
	6)cat ./EpNro1/procesado.log;;
	7)exit

esac

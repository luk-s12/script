#! /bin/bash
#
#	autor: Lucas Cornero
#
#	description: Este script fue pensado para sistemas linux de 32 bits dado
#				 que no hay gran variedad de software en esa arquitectura para poder operar con GitHub
#



#colores
celeste="\e[1;36m"
blanco="\e[1;37m"
sinColor="\e[0m"

function descarga {

clear

if hash git 2> /dev/null; then
	echo "Github ya se encuentra instalado..."
	sleep 2
clear

else

	sudo apt-get update
	sudo apt-get install git
	sleep 2
fi

}

function configura {
		
clear

read -p 'Introduzca el nombre de usuario: ' usuario
git config --global user.name $usuario
		
echo
		
read -p 'Introduzca el email: ' email
git config --global user.email $email
	
}

function directorio {
	
clear
		
read -p 'Introduzca el  directorio donde estan los archivos: ' archivos

if cd $archivos 2> /dev/null; then
	echo -e "\nAcceso correcto...\n"
else
	echo -e "\nDirectorio incorrecto...\n"
fi
		
sleep 1	

}

function mostraRuta {
		
clear
		
pwd
		
sleep 2

}

function clona {
	
clear
		
read -p 'Introduzca la URL del repositorio : ' clonar
git clone "$clonar" 
		
sleep 2		

}

function creaInit {
	
clear

git init
		
sleep 2

}

function seleccionDeOpciones () {

lista=( "Volver_al_menu" "Seleccionar_todos_los_archivos_nuevos_o_modificados" `ls`)

contador=0

echo -e "$celeste Opcion\tArchivo$sinColor"

for i in ${lista[*]}; do

	echo -e " [$celeste$contador$sinColor]\t$blanco$i$sinColor"
	((contador++))

done

echo
read -p 'Introduzca la opcion que desea :  ' opcion

if ((( $opcion > 0 ))  && (( $opcion <= ${#lista[*]}))) 2> /dev/null ; then
		
	if [ $opcion == 1 ]; then
		$1 $2 $3 $4 "."
	else
		$1 $2 $3 $4 "${lista[((--$opcion))]}"
	fi	
	
	read -p 'Introduzca el commit o cero " 0 "  para volver al menu : ' commit
		
		if [ "$commit" != "0" ]; then		
			git commit -m "$commit"

			echo

			git push --force origin master

			echo
		fi		
else

	if [ $opcion != 0 ]; then
		echo -e "\nOpción incorrecta..."
	fi

fi

}

function subiArchivos {

clear

comando="git add"

seleccionDeOpciones $comando
		
sleep 1
		
}

function repoRemoto {

clear
		
read -p 'Introduzca la URL del repositorio: ' repositorio 
		
git remote add origin "$repositorio"

git remote -v

sleep 3	
		
}

function sincroniza {

clear

git pull origin master

sleep 3

}

function sali {

clear

exit 0	

}

function default {
	
clear
		
echo 'Se introduzco una opción incorrecta.Vuelve a intentarlo'
		
sleep 4
		
}

function elimina {

clear	

git add -u

comando="git rm --cached -r" 

seleccionDeOpciones $comando "remove"

}

function guardaRepositorios {

cd

if [ -d .scriptGitHub ]; then

	escribiRepositorios

else

	mkdir .scriptGitHub
	
	escribiRepositorios
fi


}

function escribiRepositorios { 
	
	cd .scriptGitHub
	
	read -p "Introduzca la url del repositorio: " repositorio
	
	echo $repositorio >> repositorios.txt

}


function interfaz {
	
echo -e "$celeste
                  
				▒█▀▄▀█ █▀▀ █▀▀▄ █░░█ 
				▒█▒█▒█ █▀▀ █░░█ █░░█ 
				▒█░░▒█ ▀▀▀ ▀░░▀ ░▀▀▀ $sinColor"
	     
echo -e "	
\t\t$celeste  1$sinColor$blanco) Descargar GitHub
\t\t$celeste  2$sinColor$blanco) Configurar cuenta
\t\t$celeste  3$sinColor$blanco) Ir a la ruta
\t\t$celeste  4$sinColor$blanco) Mostrar la ruta
\t\t$celeste  5$sinColor$blanco) Clonar  repositorio
\t\t$celeste  6$sinColor$blanco) Crear init
\t\t$celeste  7$sinColor$blanco) Subir archivo/os
\t\t$celeste  8$sinColor$blanco) Eliminar achivo/os$sinColor
\t\t$celeste  9$sinColor$blanco) Añadir el repositorio original como un remoto
\t\t$celeste 10$sinColor$blanco) Sincronizar repositorio
\t\t$celeste 11$sinColor$blanco) Guardar reposistorios
\t\t$celeste 12$sinColor$blanco) Salir$sinColor\n"

}

clear

while : 
do

interfaz

read -p 'Introduzca la opcion : ' opcion
echo

case $opcion in
1) descarga ;;
2) configura ;;
3) directorio ;;
4) mostraRuta ;;
5) clona ;;
6) creaInit ;;
7) subiArchivos ;;
8) elimina ;;
9) repoRemoto ;;
10) sincroniza ;;
11) guardaRepositorios ;;	
12) sali ;;
*) default
	esac
clear

done

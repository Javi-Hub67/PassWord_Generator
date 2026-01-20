#!/bin/bash

archivo="contraseñas.txt"

while true; do
    echo "====Generador de Contraseñas===="
    echo " 1. Generar una contraseña"
    echo " 2. Salir"
    read -p "Elija una opción: " opcion

    case $opcion in 
        1)
        #Pedir longitud contraseña
            read -p "Inroduce una longitud de contraseña de (8-32): " longitud
            if [[ ! $longitud =~ ^[0-9]+$ ]] || [[ $longitud -lt 8 ]] || [[ $longitud -gt 32 ]]; then
                echo "Introduce un numero válido (8-32)"
                continue
            fi

            #-r es .toLowerCase
            read -rp "¿Incluir mayúsculas? (s/n): " mayusculas  
            read -rp "¿Incluir números? (s/n): " numeros  
            read -rp "¿Incluir carácteres especiales? (s/n): " especiales  

            if [[ $mayusculas != "s" && $numeros != "s" && $especiales != "s" ]]; then
                echo "Error, debes elegir al menos una opción"
                continue
            fi

            #Generar carácteres de mi motor de contraseñas

            caracteres="abcdefghijklmnñopqrstuvwxyz"

            if [[ $mayusculas == "s" ]]; then
                caracteres+="ABCDEFGHIJKLMNÑOPQRSTUVWZYZ"
            fi
            if [[ $numeros == "s" ]]; then
                caracteres+="0123456789"
            fi
            if [[ $especiales == "s" ]]; then
                caracteres+="!@#$%&()?¿'¡^*[]{}:+/-"
            fi

            #Generar el motor de contraseñas

            password=""

            for (( i=0; i<$longitud; i++ )); do
                rand=$(( RANDOM % ${#caracteres} ))
                password+="${caracteres:$rand:1}"
            done

            echo " Tu contraseña generada: $password "

            # >> significa redirigir, mantiene lo anterior y escriba
            echo "$password" >> $archivo
        ;;
        2)
            echo "Saliendo del sistema..."
            exit 0
        ;;

        *)
        echo "Opción no valida, introduce un número del 1 al 2"
        ;;
    esac
done

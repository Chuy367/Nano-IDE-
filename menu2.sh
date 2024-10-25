#!/bin/bash

while true; do
    # Verifica si nano está abierto y obtiene el archivo en edición
    archivo=$(ps aux | grep '[n]ano' | awk '{for(i=1;i<=NF;i++){if($i=="nano"){print $(i+1)}}}')

    if [[ -n "$archivo" ]]; then
        # Extrae la extensión del archivo
        extension="${archivo##*.}"
    else
        extension="ninguno"
    fi

    clear
    echo "Archivo actual: $archivo"
    echo "Extensión: .$extension"

    # Opciones dinámicas basadas en la extensión del archivo
    opciones=()
    case "$extension" in
        c)
            opciones=("Compilar C" "Ejecutar C" "Depurar C" "Salir")
            ;;
        py)
            opciones=("Ejecutar Python" "Depurar Python" "Salir")
            ;;
        sh)
            opciones=("Ejecutar Script" "Salir")
            ;;
        html)
            opciones=("Servidor html" "Salir")
            ;;

	*)
            opciones=("Esperando archivo soportado..." "Salir")
            ;;
    esac

    # Genera un menú con select
    echo "Seleccione una opción:"
    select opcion in "${opciones[@]}"; do
        case $opcion in
            "Compilar C")
                gcc "$archivo" -o "${archivo%.c}.out" && echo "Compilación exitosa!"
                break
                ;;
            "Ejecutar C")
                "./${archivo%.c}.out"
                break
                ;;
            "Depurar C")
                gdb "./${archivo%.c}.out"
                break
                ;;
            "Ejecutar Python")
                python3 "$archivo"
                break
                ;;
            "Depurar Python")
                python3 -m pdb "$archivo"
                break
                ;;
            "Ejecutar Script")
                bash "$archivo"
                break
                ;;
            "Servidor html")
                ifconfig
		python3 -m http.server
                break
		;;
	    "Salir")
                echo "Saliendo..."
                exit 0
                ;;
            "Esperando archivo soportado...")
                echo "No hay acciones disponibles para esta extensión."
                break
                ;;
            *)
                echo "Opción inválida. Intente nuevamente."
                ;;
        esac
    done

    sleep 2  # Espera 2 segundos antes de volver al bucle
done

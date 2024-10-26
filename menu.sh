#!/bin/bash

# Función para actualizar el archivo en edición
actualizar_archivo() {
    archivo=$(ps aux | grep '[n]ano' | awk '{for(i=1;i<=NF;i++){if($i=="nano"){print $(i+1)}}}')
    if [[ -n "$archivo" ]]; then
        extension="${archivo##*.}"
    else
        archivo="Ninguno"
        extension="ninguno"
    fi
}

# Llamada inicial a la función para obtener el archivo
actualizar_archivo

# Bucle principal
while true; do
    clear  # Limpia la pantalla
    echo "Archivo actual: $archivo"
    echo "Extensión: .$extension"
    echo "Seleccione una opción:"
    

    # Genera opciones dinámicas basadas en la extensión
    opciones=("Actualizar" "GitHub" "Salir")  # Opciones básicas disponibles
    if [[ "$extension" == "c" ]]; then
        opciones=("Compilar C" "Ejecutar C" "Depurar C" "${opciones[@]}")
    elif [[ "$extension" == "py" ]]; then
        opciones=("Ejecutar Python" "Depurar Python" "${opciones[@]}")
   elif [[ "$extension" == "html" ]]; then
        opciones=("Servidor html"  "${opciones[@]}")

    elif [[ "$extension" == "sh" ]]; then
        opciones=("Ejecutar Script" "${opciones[@]}")
    fi

    # Mostrar opciones usando 'select'
    select opcion in "${opciones[@]}"; do
        case $opcion in
            "Compilar C")
		tmux send-keys -t 1 "gcc '$archivo' -o '${archivo%.c}.out' && echo '¡Compilación exitosa!'" Enter
		tmux select-pane -t 1
                break
                ;;
            "Ejecutar C")
		tmux send-keys -t 1 "${archivo%.c}.out" Enter
                tmux select-pane -t 1
                break
                ;;
            "Depurar C")
                tmux send-keys -t 1 "gdb './${archivo%.c}.out'" Enter
		tmux send-keys -t 1  "chmod +x '$archivo'" Enter
		tmux select-pane -t 1
                break
                ;;
            "Ejecutar Python")
		tmux send-keys -t 1 "python3 '$archivo'" Enter
                tmux select-pane -t 1
                break
                ;;
            "Depurar Python")
               tmux send-keys -t 1 "python3 -m pdb '$archivo'" Enter
		tmux select-pane -t 1
                break
                ;;
            "Ejecutar Script")
		tmux send-keys -t 1 "bash '$archivo'" Enter
                tmux select-pane -t 1
                break
                ;;
            "Servidor html")
		tmux send-keys -t 1 "ifconfig" Enter
		tmux send-keys -t 1 "python3 -m http.server" Enter
		tmux select-pane -t 1
                break
                ;;

	    "Actualizar")
                actualizar_archivo
                echo "Archivo actualizado: $archivo"
                break
                ;;
            "Salir")
                echo "Saliendo..."
                exit 0
                ;;
            "GitHub")
		clear
		./menu-git.sh
		;;
		*)
                echo "Opción inválida, intenta de nuevo."
                ;;
        esac
    done

    sleep 2  # Espera 2 segundos antes de volver al menú
done

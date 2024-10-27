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

# Función para abrir el menú del lenguaje correspondiente
abrir_menu_lenguaje() {
    menu_path="menus/menu_$extension.sh"
    if [[ -f "$menu_path" ]]; then
        echo "Abriendo menú para .$extension..."
        bash "$menu_path"
    else
        echo "No se encontró un menú para .$extension"
    fi
}

# Bucle principal
while true; do
    clear  # Limpia la pantalla
    echo "Archivo actual: $archivo"
    echo "Extensión: .$extension"
    echo "Seleccione una opción:"

    # Opciones básicas disponibles
    opciones=("Abrir menú del lenguaje" "Actualizar" "GitHub" "Salir")

    # Mostrar opciones usando 'select'
    select opcion in "${opciones[@]}"; do
        case $opcion in
            "Abrir menú del lenguaje")
                abrir_menu_lenguaje
                break
                ;;
            "Actualizar")
                actualizar_archivo
                echo "Archivo actualizado: $archivo"
                break
                ;;
            "GitHub")
                clear
                ./menus/menu-git.sh
                break
                ;;
            "Salir")
                echo "Saliendo..."
                exit 0
                ;;
            *)
                echo "Opción inválida, intenta de nuevo."
                ;;
        esac
    done

    sleep 2  # Espera 2 segundos antes de volver al menú
done

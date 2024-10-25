#!/bin/bash

# Usa fzf para navegar los archivos y seleccionar uno
archivo=$(find . -type f | fzf --prompt="Selecciona un archivo: " --height=40% --border)

# Verifica que se haya seleccionado un archivo
if [[ -n "$archivo" ]]; then
    nano "$archivo"
else
    echo "No se seleccionó ningún archivo."
fi

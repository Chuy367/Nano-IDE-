#!/bin/bash
echo "=== Menú de PHP ==="
select opcion in "Ejecutar Script PHP" "Iniciar Servidor PHP" "Salir"; do
    case $opcion in
        "Ejecutar Script PHP")
            tmux send-keys -t 1 "php '$archivo'" Enter
            ;;
        "Iniciar Servidor PHP")
            tmux send-keys -t 1 "php -S localhost:8000" Enter
            ;;
        "Salir") exit 0 ;;
        *) echo "Opción inválida, intenta de nuevo." ;;
    esac
done

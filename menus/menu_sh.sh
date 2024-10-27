#!/bin/bash
echo "=== Menú de Bash ==="
select opcion in "Ejecutar Script" "Salir"; do
    case $opcion in
        "Ejecutar Script")
            tmux send-keys -t 1 "bash '$archivo'" Enter
            ;;
        "Salir") exit 0 ;;
        *) echo "Opción inválida, intenta de nuevo." ;;
    esac
done

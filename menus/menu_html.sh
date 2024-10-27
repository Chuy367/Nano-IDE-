#!/bin/bash
echo "=== Menú de HTML ==="
select opcion in "Iniciar Servidor Web" "Salir"; do
    case $opcion in
        "Iniciar Servidor Web")
            tmux send-keys -t 1 "python3 -m http.server" Enter
            ;;
        "Salir") exit 0 ;;
        *) echo "Opción inválida, intenta de nuevo." ;;
    esac
done

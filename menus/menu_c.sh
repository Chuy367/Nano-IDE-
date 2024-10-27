#!/bin/bash
echo "=== Menú de C ==="
select opcion in "Compilar" "Ejecutar" "Depurar" "Salir"; do
    case $opcion in
        "Compilar")
            tmux send-keys -t 1 "gcc '$archivo' -o '${archivo%.c}.out' && echo '¡Compilación exitosa!'" Enter
            ;;
        "Ejecutar")
            tmux send-keys -t 1 "./${archivo%.c}.out" Enter
            ;;
        "Depurar")
            tmux send-keys -t 1 "gdb ./\"${archivo%.c}.out\"" Enter
            ;;
        "Salir") exit 0 ;;
        *) echo "Opción inválida, intenta de nuevo." ;;
    esac
done

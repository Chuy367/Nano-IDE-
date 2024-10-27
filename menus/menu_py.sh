#!/bin/bash
echo "=== Menú de Python ==="
select opcion in "Ejecutar" "Depurar" "Salir"; do
    case $opcion in
        "Ejecutar")
            tmux send-keys -t 1 "python3 '$archivo'" Enter
            ;;
        "Depurar")
            tmux send-keys -t 1 "python3 -m pdb '$archivo'" Enter
            ;;
        "Salir") exit 0 ;;
        *) echo "Opción inválida, intenta de nuevo." ;;
    esac
done

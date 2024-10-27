#!/bin/bash
echo "=== Menú de Assembly ==="
select opcion in "Compilar ASM (nasm)" "Ejecutar ASM" "Salir"; do
    case $opcion in
        "Compilar ASM (nasm)")
            tmux send-keys -t 1 "nasm -f elf64 '$archivo' && ld -o '${archivo%.asm}' '${archivo%.asm}.o'" Enter
            ;;
        "Ejecutar ASM")
            tmux send-keys -t 1 "./${archivo%.asm}" Enter
            ;;
        "Salir") exit 0 ;;
        *) echo "Opción inválida, intenta de nuevo." ;;
    esac
done

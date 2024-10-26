
#!/bin/bash

# Submenú de GitHub
while true; do
  echo "=== Opciones de GitHub ==="
  echo "1) Agregar y subir archivos al repositorio"
  echo "2) Mostrar estado del repositorio"
  echo "3) Ver historial de commits"
  echo "4) Descargar cambios del remoto (pull)"
  echo "5) Volver al menú principal"
  read -p "Opción: " opcion_github

  case $opcion_github in
    1)
	tmux send-keys -t 1 "git add . && read -p 'Escribe el mensaje del commit: ' mensaje && git commit -m '$mensaje' && git push origin master" Enter

      
      ;;
    2)
	tmux send-keys -t 1 "git status" Enter
      ;;
    3)
	tmux send-keys -t 1 "git log --oneline" Enter
      ;;
    4)
	tmux send-keys -t 1 "git pull origin master" Enter
      ;;
    5)
      clear
      break

      ;;
    *)
      echo "Opción no válida. Inténtalo de nuevo."
      ;;
  esac
done

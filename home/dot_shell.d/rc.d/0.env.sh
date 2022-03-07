if [ -d "$HOME/bin" ]; then
  case ":$PATH:" in
  *:$HOME/bin:*) ;;
  *) export PATH="$HOME/bin:$PATH" ;;  
  esac
 
fi

if [ -d "$HOME/.local/bin" ]; then
  case ":$PATH:" in
  *:$HOME/.local/bin:*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;  
  esac
fi
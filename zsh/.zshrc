# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

function nt() {
  # Hämtar namnet på mappen vi står i
  local dir_name=$(basename "$(pwd)")

  # LAGERKOLL: Är vi utanför tmux?
  if [ -z "$TMUX" ]; then
    # 1. Skapa en ny session (-d för att inte hoppa in direkt)
    # 2. Döpa första fönstret till 'main'
    tmux new-session -d -s "work" -n "main"
    
    # 3. Om vi startade i en projektmapp, skapa projektfönstret direkt
    # Annars, hoppa bara in i 'main'
    if [ "$dir_name" != "$(basename "$HOME")" ]; then
        tmux new-window -t "work" -n "$dir_name" "nvim ."
        tmux split-window -h -p 20 -t "work"
    fi
    
    tmux attach-session -t "work"
  else
    # LAGERKOLL: Vi är redan inne i tmux
    # Skapa det nya projektfönstret baserat på nuvarande mapp
    tmux new-window -n "$dir_name" "nvim ."
    tmux split-window -h -p 20
  fi
}

# Öppna en specifik mapp i ett nytt fönster
function op() {
  local path=$1
  local name=$(basename "$path")

  if [ -z "$TMUX" ]; then
    tmux new-window -s "$name" -c "$path" "nvim ."
  else
    tmux new-window -n "$name" -c "$path"
  fi
}

source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

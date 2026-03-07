# 1. LAGER: Snabbstart (P10k)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 2. LAGER: Miljövariabler
export PATH=$HOME/.local/bin:$PATH

# 3. LAGER: Alias & Funktioner
alias gcb="./gradlew clean build"
alias edot="cd ~/dotfiles && nvim ."

nt() {
  local dir_name=$(basename "$(pwd)")

  if [ -z "$TMUX" ]; then
    tmux new-session -d -s "work" -n "main"
    if [ "$dir_name" != "$(basename "$HOME")" ]; then
      tmux new-window -t "work" -n "$dir_name" "nvim .; zsh"
      tmux split-window -h -p 20 -t "work"
    fi
    tmux attach-session -t "work"
  else
    tmux new-window -n "$dir_name" "nvim .; zsh"
    tmux split-window -h -p 20
  fi
}

# 4. LAGER: Systemkonfiguration (CachyOS)
source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# 5. LAGER: Temakonfiguration (P10k)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

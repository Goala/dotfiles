export PATH="$HOME/.local/bin:$PATH"

# --- Antidote & Plugins ---
source ~/.antidote/antidote.zsh
antidote load

# --- Starship Prompt ---
eval "$(starship init zsh)"

# --- Zsh Completion ---
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi

# --- Completion Settings ---
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# --- Aliases ---
alias ll='ls -lah --color=auto'
alias zup='antidote update && antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh && source ~/.zshrc'

# --- fzf ---
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS="--height 40% --border=bottom --layout=reverse --info=inline"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

# --- FNM ---
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd)"

# --- History & Komfort ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups

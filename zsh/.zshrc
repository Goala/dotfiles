export PATH="$HOME/.local/bin:$PATH"

# --- Zsh Completion ---
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi
autoload -U +X bashcompinit && bashcompinit

# --- Completion Settings ---
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# --- Antidote & Plugins ---
source ~/.antidote/antidote.zsh
antidote load

# --- Starship Prompt ---
eval "$(starship init zsh)"

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

# --- zoxide ---
eval "$(zoxide init zsh)"

# --- editor ---
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# --- AWS Credentials Management ---
get_aws_credentials() {
  if [ -z "$1" ]; then
    echo "Usage: export_aws_credentials <profile>"
    return 1
  fi

  local profile="$1"
  eval "$(aws configure export-credentials --profile $profile --format env)"
  export AWS_PROFILE="$profile"
  export AWS_REGION='eu-central-1'

}

_aws_profile_completion() {
  local -a profiles
  profiles=(${(f)"$(grep -h '^\[profile ' ~/.aws/config 2>/dev/null | sed -e 's/\[profile //' -e 's/]//')"})
  _describe 'aws profile' profiles
}

compdef _aws_profile_completion get_aws_credentials

clear_aws_credentials() {
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
  unset AWS_PROFILE
  echo "AWS credentials cleared."
}

# --- Local Configuration ---
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

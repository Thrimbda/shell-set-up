# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
# Context
# DEFAULT_USER="thrimbda"

# VCS icons
POWERLEVEL9K_VCS_GIT_ICON=$'\uf1d3'
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uf113'
POWERLEVEL9K_VCS_STAGED_ICON=$'\uf055'
POWERLEVEL9K_VCS_UNSTAGED_ICON=$'\uf071'
POWERLEVEL9K_VCS_UNTRACKED_ICON=$'\uf00d'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$'\uf0ab '
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$'\uf0aa '

# Time
POWERLEVEL9K_TIME_FORMAT="%F{black}\uf017 %D{%I:%M}%f"
POWERLEVEL9K_TIME_BACKGROUND='blue'

# plugins
plugins=(
  autojump
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# MISC
zstyle ':completion:*:*:make:*' tag-order 'targets'

# alias
# alias git-track="git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done"

# environments


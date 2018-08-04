#!/bin/sh

set -e

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

if [ ! -n "$ZSH" ]; then
  ZSH=~/.oh-my-zsh
fi

# check if zsh installed
if [ -d "$ZSH" ]; then
  printf "${YELLOW}You already have Oh My Zsh installed.${NORMAL}\n"
  printf "You'll need to remove $ZSH if you want to re-install.\n"
  exit
else
  # check if curl installed
  if ! command -v git --version 2>&1 >/dev/null ; then
    printf "${YELLOW}Curl is not installed!${NORMAL} Please install curl first!\n"
    exit
  fi
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# check if git installed
if ! command -v git --version 2>&1 >/dev/null ; then
  printf "${YELLOW}Git is not installed!${NORMAL} Please install git first!\n"
  exit
fi

# install theme
if [ ! -n "$POWERLEVEL9K" ]; then
 POWERLEVEL9K=$ZSH/custom/themes/powerlevel9k
fi

if [ ! -d "$POWERLEVEL9K" ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

# install plugins
if [ ! -n "$AUTOSUGGESTIONS" ]; then
 AUTOSUGGESTIONS=$ZSH/custom/plugins/zsh-autosuggestions
fi

if [ ! -d "$AUTOSUGGESTIONS" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $AUTOSUGGESTIONS
fi

if [ ! -n "$SYNTAX_HIGHLIGHTING" ]; then
 SYNTAX_HIGHLIGHTING=$ZSH/custom/plugins/zsh-autosuggestions
fi

if [ ! -d "$SYNTAX_HIGHLIGHTING" ]; then
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $SYNTAX_HIGHLIGHTING
fi

# check if curl installed
if ! command -v git --version 2>&1 >/dev/null ; then
  printf "${YELLOW}Curl is not installed!${NORMAL} Please install curl first!\n"
  exit
fi
curl -o ~/.zshrc -L https://raw.githubusercontent.com/Thrimbda/shell-set-up/master/.zshrc

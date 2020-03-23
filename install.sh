main() {
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

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  if ! command -v zsh >/dev/null 2>&1; then
    printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
    exit
  fi

  if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
  fi

  if [ -d "$ZSH" ]; then
    printf "${YELLOW}You already have Oh My Zsh installed.${NORMAL}\n"
    printf "You'll need to remove $ZSH if you want to re-install.\n"
  else
    # Prevent the cloned repository from having insecure permissions. Failing to do
    # so causes compinit() calls to fail with "command not found: compdef" errors
    # for users with insecure umasks (e.g., "002", allowing group writability). Note
    # that this will be ignored under Cygwin by default, as Windows ACLs take
    # precedence over umasks except for filesystems mounted with option "noacl".
    umask g-w,o-w

    printf "${BLUE}Cloning Oh My Zsh...${NORMAL}\n"
    command -v git >/dev/null 2>&1 || {
      echo "Error: git is not installed"
      exit 1
    }
    # The Windows (MSYS) Git is not compatible with normal use on cygwin
    if [ "$OSTYPE" = cygwin ]; then
      if git --version | grep msysgit > /dev/null; then
        echo "Error: Windows/MSYS Git is not supported on Cygwin"
        echo "Error: Make sure the Cygwin git package is installed and is first on the path"
        exit 1
      fi
    fi
    env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$ZSH" || {
      printf "Error: git clone of oh-my-zsh repo failed\n"
      exit 1
    }

    printf "${BLUE}Looking for an existing zsh config...${NORMAL}\n"
    if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
      printf "${YELLOW}Found ~/.zshrc.${NORMAL} ${GREEN}Backing up to ~/.zshrc.pre-oh-my-zsh${NORMAL}\n";
      mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
    fi

    # If this login shell is not already "zsh", attempt to switch.
    TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
    if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
      # If this platform provides a "chsh" command (not Cygwin), do it, man!
      if hash chsh >/dev/null 2>&1; then
        printf "${BLUE}Time to change your default shell to zsh!${NORMAL}\n"
        chsh -s $(grep /zsh$ /etc/shells | tail -1)
      # Else, suggest the user do so manually.
      else
        printf "I can't change your shell automatically because this system does not have chsh.\n"
        printf "${BLUE}Please manually change your default shell to zsh!${NORMAL}\n"
      fi
    fi

    printf "${GREEN}"
    echo '         __                                     __   '
    echo '  ____  / /_     ____ ___  __  __   ____  _____/ /_  '
    echo ' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '
    echo '/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '
    echo '\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '
    echo '                        /____/                       ....is now installed!'
    printf "${YELLOW}and hacked by thrimbda!${GREEN}"
    echo ''
    echo ''
    echo 'Please look over the ~/.zshrc file to select plugins, themes, and options.'
    echo ''
    echo 'p.s. Follow us at https://twitter.com/ohmyzsh.'
    echo ''
    echo 'p.p.s. Get stickers and t-shirts at https://shop.planetargon.com.'
    echo ''
    printf "${NORMAL}\n"
  fi


  # install theme
  if [ ! -n "$POWERLEVEL10K" ]; then
    POWERLEVEL10K=$ZSH/custom/themes/powerlevel10k
  fi

  if [ ! -d "$POWERLEVEL10K" ]; then
    printf "${BLUE}install theme powerlevel9k into your oh-my-zsh environment${NORMAL}\n"
    env git clone https://github.com/bhilburn/powerlevel9k.git $POWERLEVEL10K || {
      printf "Error: git clone of oh-my-zsh repo failed\n"
      exit 1
    }
  fi

  # install plugins
  if [ ! -n "$AUTOSUGGESTIONS" ]; then
    AUTOSUGGESTIONS=$ZSH/custom/plugins/zsh-autosuggestions
  fi

  if [ ! -d "$AUTOSUGGESTIONS" ]; then
    printf "${BLUE}install plugin auto suggestion into your oh-my-zsh environment${NORMAL}\n"
    env git clone https://github.com/zsh-users/zsh-autosuggestions.git $AUTOSUGGESTIONS || {
      printf "Error: git clone of zsh-autosuggestions repo failed\n"
      exit 1
    }
  fi

  if [ ! -n "$SYNTAX_HIGHLIGHTING" ]; then
    SYNTAX_HIGHLIGHTING=$ZSH/custom/plugins/zsh-syntax-highlighting
  fi

  if [ ! -d "$SYNTAX_HIGHLIGHTING" ]; then
    printf "${BLUE}install plugin syntax highlighting into your oh-my-zsh environment${NORMAL}\n"
    env git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $SYNTAX_HIGHLIGHTING || {
      printf "Error: git clone of zsh-syntax-highlighting repo failed\n"
      exit 1
    }
  fi

  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    printf "${BLUE}make your old .zshrc backup...${NORMAL}"
    mv ~/.zshrc ~/.zshrc.back
  fi

  # its obviously that people who can run this would have curl or wget.
  if command -v curl 2>&1 >/dev/null ; then
    curl -o ~/.zshrc -L https://raw.githubusercontent.com/Thrimbda/shell-set-up/master/.zshrc
    curl -o ~/.p10k.zsh -L https://raw.githubusercontent.com/Thrimbda/shell-set-up/master/.p10k.zsh
  elif command -v wget 2>&1 >/dev/null ; then
    wget -O ~/.zshrc https://raw.githubusercontent.com/Thrimbda/shell-set-up/master/.zshrc
    wget -O ~/.p10k.zsh https://raw.githubusercontent.com/Thrimbda/shell-set-up/master/.p10k.zsh
  else
    printf "${YELLOW}I don't know where did you get this script.${NORMAL} Please install curl or wget first!\n"
    exit
  fi
  sed "/^export ZSH=/ c\\
  export ZSH=\"$ZSH\"
  " ~/.zshrc > ~/.zshrc-omztemp
  mv -f ~/.zshrc-omztemp ~/.zshrc

  printf "${GREEN}"
  echo ' ___________ __                            __         __     '
  echo '/____  ____// /                           / /        / /     '
  echo '    / /    / /____  _____ ( ) __  ___    / /__  ____/ /_____ '
  echo '   / /    /  __  / / ___// / /  |/   |  / __  \/ __  // __  |'
  echo '  / /    / /  / / / /   / / / /|  /| | / /_/ // /_/ // /_/  |'
  echo ' /_/    /_/  /_/ /_/   /_/ /_/ |_/ |_| \____/ \____/ \____|_| ...empower your shell, enjoy yourself.'
  printf "${NORMAL}"
  env zsh -l
}

main

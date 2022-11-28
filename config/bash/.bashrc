##-----------------------------------------------------------------------------
## @author       Kenrick JORUS
## @license      MIT License
## @link         http://kenijo.github.io/WSH/
## @description  Initialization script when starting Bash
##-----------------------------------------------------------------------------

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

################################################################################
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

################################################################################
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# Source the user's alias definitions if it exists
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

################################################################################
# Source a custom configuration
if [ -f ~/.custom ]; then
  source ~/.custom
fi

################################################################################
# Define the user's personal color definition
if [ -f ~/.dircolors ]; then
  eval "$(dircolors ~/.dircolors)"
fi

################################################################################
# Install Vim-Plug and add the Nord them
if [ ! -f ~/.vim/colors/nord.vim ]; then
  echo "Configuring Vim Nord theme"
  curl -s -fLo ~/.vim/colors/nord.vim --create-dirs https://raw.githubusercontent.com/arcticicestudio/nord-vim/main/colors/nord.vim
  sed -i 's/let s:nord3_term = "8"/let s:nord3_term = "6"/' ~/.vim/colors/nord.vim
  echo "colorscheme nord" > ~/.vimrc
fi

################################################################################
# History Options: Make bash append rather than overwrite the history on disk
shopt -s histappend

# History Options: Don't save duplicate lines through the history
export HISTCONTROL=ignorespace:erasedups

################################################################################
# Shell Options: Use case-insensitive filename globing
shopt -s nocaseglob
bind -s 'set completion-ignore-case on'

# Shell Options: When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Shell Options: Colored GCC warnings and errors
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Check the window size after each command and update the values of LINES and COLUMNS.
shopt -s checkwinsize

################################################################################
# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

################################################################################
# Output distro description when logging in
if lsb_release &> /dev/null; then
  echo `lsb_release --description --short`
fi

################################################################################
# Set Enhance Prompt
# PROMPT_COMMAND='printf "\n\e[0;37m[Folder Content: \e[0;34m$(ls -1 | wc -l | sed "s: ::g") files, $(ls -lah | grep -m 1 total | sed "s/total //")\e[0;37m]\n\e[0;37m[Memory Usage:\e[0;34m $((`sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))M / $((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))M\e[0;37m]\n\e[0;37m[Path: \e[0;34m`pwd`\e[0;37m]\e[0m\n"';
# export PROMPT_COMMAND
# Set Prompt
export PS1="\[\n\]\[\e[0;37m\][Path:\[\e[0;34m\] \w\[\e[0;37m\]]\n\[\e[0;\`if [[ \$? = "0" ]]; then echo "32m"; else echo "31m"; fi\`\][\u@\h] \[\e[0;37m\]λ \[\e[0m\]";
export PS2="\[\e[0;37m\]> \[\e[0m\]";

################################################################################
# Define the session start folder
#cd <PATH> &> /dev/null

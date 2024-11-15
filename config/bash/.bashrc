#-------------------------------------------------------------------------------
# @link          http://kenijo.github.io/WSH/
# @description   Initialization script when starting Bash
# @license       MIT License
#-------------------------------------------------------------------------------

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
# You may want to put all your aliases into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# Source the user's alias definitions if it exists
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

################################################################################
# Source a custom configuration
if [ -f ~/.bash_custom ]; then
    source ~/.bash_custom
fi

################################################################################
# Define the user's personal color definition
if [ -f ~/.dircolors ]; then
    eval "$(dircolors ~/.dircolors)"
fi

################################################################################
# History Options: Make bash append rather than overwrite the history on disk
shopt -s histappend

# History Options: Set history file location
export HISTFILE=~/.bash_history

# History Options: Immediately persist commands to the history
export  PROMPT_COMMAND="history -w"

# History Options: Colon-separated list of values controlling how commands are saved in the history list
#   ignorespace – CLI, which begin with a space character, are not saved in the history list.
#   ignoredups  – Do not save duplicate commands.
#   ignoreboth  – It is a shortcut to both ignorespace and ignoredups.
#   erasedups   – All previous lines matching the current line will be removed from the history list before that line is saved.
export HISTCONTROL=ignorespace:ignoredups:erasedups

# History Options: Colon-separated list of patterns to not save to the history
export HISTIGNORE='su:exit'

# History Options: The maximum number of commands in the history
export HISTSIZE=1000

# History Options: The maximum number of lines in the history
export HISTFILESIZE=2000

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
# Set Prompt
export PS1="\[\n\]\[\e[0;37m\][Path:\[\e[0;34m\] \w\[\e[0;37m\]]\n\[\e[0;\`if [[ \$? = "0" ]]; then echo "32m"; else echo "31m"; fi\`\][\u@\h] \[\e[0;37m\]λ \[\e[0m\]";
export PS2="\[\e[0;37m\]> \[\e[0m\]";

################################################################################
# Define the session start folder
#cd <PATH> &> /dev/null

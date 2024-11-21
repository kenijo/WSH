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
# Define aliases
alias df='df -h'                          # Default to human readable figures
alias du='du -h'                          # Default to human readable figures

alias less='less -r'                      # raw control characters
alias whence='type -a'                    # where, of a sort\

alias grep='grep --color=auto'            # show differences in color
alias egrep='egrep --color=auto'          # show differences in color
alias fgrep='fgrep --color=auto'          # show differences in color

# ls --help
#  -A, --almost-all         do not list implied . and ..
#  -F, --classify           append indicator (one of */=>@|) to entries
#  -h, --human-readable     with -l, print sizes in human readable format (e.g., 1K 234M 2G)
#  -N, --literal            print entry names without quoting
#  -v                       natural sort of (version) numbers within text (however it is case sensite: a comes after Z)
#  --color[=WHEN]           colorize the output. WHEN defaults to 'always' or can be 'never' or 'auto'
#  --format=WORD            long -l, single-column -1, vertical -C
#  --time-style=STYLE       STYLE: full-iso, long-iso, iso, locale, +FORMAT
#  --sort=WORD              sort by WORD instead of name: none (-U), size (-S), time (-t), version (-v), extension (-X)
#  -g                       like -l, but do not list owner
#  -o                       like -l, but do not list group informationalias ls='ls -AFhN --color=auto --time-style=long-iso --format=vertical'
alias ls='ls -AFhN --color=auto --time-style=long-iso --format=vertical'
alias dir='ls -AFhN --color=auto --time-style=long-iso --format=vertical'
alias ll='ls -AFhN --color=auto --time-style=long-iso --format=long'

alias cls='clear'
alias md=mkdir
alias rd=rmdir
alias vi='vim'
alias update='sudo apt update && sudo apt full-upgrade && sudo apt autoremove'
alias upgrade='sudo do-release-upgrade'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Displays what is the command behind an alias
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

################################################################################
# Source a custom alias definitions.
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
# Set Prompt
build_prompt() {
    lastErrorCode=$?;

    reset="\[\e[0m\]";
    bold="\[\e[1m\]";
    black="\[\e[0;30m\]";
    red="\[\e[0;31m\]";
    green="\[\e[0;32m\]";
    yellow="\[\e[0;33m\]";
    blue="\[\e[0;34m\]";
    magenta="\[\e[0;35m\]";
    cyan="\[\e[0;36m\]";
    white="\[\e[0;37m\]";

    if [ $lastErrorCode == 0 ]; then
        getErrorLevelColor=$green;
    else
        getErrorLevelColor=$red;
    fi

    if [ $EUID == 0 ]; then
        getSymbol=$getErrorLevelColor"🛡  #> ";
    else
        getSymbol=$getErrorLevelColor" $> ";
    fi

    getComputerName="\h";
    getUserName="\u";
    getPath="\w";
    getTime=$(date +%T);

    _LEFT_LINE1=$blue"[Path: "$yellow$getPath$blue"]"$reset;
    _LEFT_LINE2=$cyan"["$getUserName"@"$getComputerName"]"$getSymbol$reset;

    _RIGHT_LINE_2="["$getTime"]";
    let _SPACING=$COLUMNS-${#_RIGHT_LINE_2}
    _RIGHT_LINE_2=$cyan$_RIGHT_LINE_2$reset;

    PS0=$(tput sc)$(tput cuu 1)$(tput cuf $_SPACING)$_RIGHT_LINE_2"\n"$(tput rc);
    PS1="\n"$_LEFT_LINE1"\n"$_LEFT_LINE2;
}
PROMPT_COMMAND=build_prompt;

################################################################################
# Define the session start folder
#cd <PATH> &> /dev/null

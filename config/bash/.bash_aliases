#-------------------------------------------------------------------------------
# @link          http://kenijo.github.io/WSH/
# @description   Script to store aliases that will be loaded by .bashrc
# @license       MIT License
#-------------------------------------------------------------------------------

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

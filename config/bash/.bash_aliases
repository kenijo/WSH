##-----------------------------------------------------------------------------
## @author       Kenrick JORUS
## @copyright    2022 Kenrick JORUS
## @license      MIT License
## @link         http://kenijo.github.io/WSH/
## @description  Define your own aliases for bash
##-----------------------------------------------------------------------------

################################################################################
# User dependent .bash_aliases file
################################################################################
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

################################################################################
# Define aliases
alias df='df -h'                          # Default to human readable figures
alias du='du -h'                          # Default to human readable figures

alias less='less -r'                      # raw control characters
alias whence='type -a'                    # where, of a sort\

alias grep='grep --color=auto'            # show differences in colour
alias egrep='egrep --color=auto'          # show differences in colour
alias fgrep='fgrep --color=auto'          # show differences in colour

# ls --help
#  -A, --almost-all           do not list implied . and ..
#  -F, --classify             append indicator (one of */=>@|) to entries
#  -h, --human-readable       with -l, print sizes in human readable format (e.g., 1K 234M 2G)
#  -N, --literal              print entry names without quoting
#  -v                         natural sort of (version) numbers within text (however it is case sensite: a comes after Z)
#  --color[=WHEN]             colorize the output. WHEN defaults to 'always' or can be 'never' or 'auto'
#  --format=WORD              long -l, single-column -1, vertical -C
#  --time-style=STYLE         STYLE: full-iso, long-iso, iso, locale, +FORMAT
#  --sort=WORD                sort by WORD instead of name: none (-U), size (-S), time (-t), version (-v), extension (-X)
#  -g                         like -l, but do not list owner
#  -o                         like -l, but do not list group informationalias ls='ls -AFhN --color=auto --time-style=long-iso --format=vertical'
alias ls='ls -AFhN --color=auto --time-style=long-iso --format=vertical'
alias dir='ls -AFhN --color=auto --time-style=long-iso --format=vertical'
alias ll='ls -AFhN --color=auto --time-style=long-iso --format=long'

alias cls='clear'                         # shortcut
alias md=mkdir                            # shortcut
alias rd=rmdir                            # shortcut
alias vi='vim'                            # shortcut

# Displays what is the command behind an alias
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
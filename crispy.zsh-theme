ZSH_THEME="crispy"

# Path
export PATH="/usr/local/sbin:$PATH"

# Set the default editor, mainly for Git, but for other things too
export VISUAL=vim
export EDITOR="$VISUAL"

# Autojump config
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Marker config
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

# Correct spelling mistakes in paths and arguments
setopt correctall

###############################################################################
# Useful aliases
###############################################################################

###############################################################################
# Shorthand
###############################################################################
alias c='clear'
alias g='grep'
# Prevent xQuartz from trying to run, when typing this common typo
alias x=:
alias xx="exit"
# Ask before doing anything dangerous
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
# Readable path
alias path='echo -e ${PATH//:/\\n}'
# Node development
alias ys="yarn start"
alias yb="yarn start"

###############################################################################
# Listing
###############################################################################
# List normal files
alias l='ls -lh'
# List everything, including hidden files
alias ll='ls -hal'
# List everything, by reverse date
alias lld='ls -thral'
# List for wildcard searches without all those subdir files
# usage:
#     lw thi*
#     lw *.txt
alias lw='ls -dhal'

###############################################################################
# Searching
###############################################################################
function findin () {
  find . -exec grep -q "$1" '{}' \; -print
}

# Shortcuts to the Mac OS Spotlight commands
# TODO: Get this working in ZSH
if [ "$OS" = "mac" ]; then
  alias f='mdfind -onlyin . -name '
  alias fs='mdfind -onlyin . '
fi

###############################################################################
# Changing directories
###############################################################################
# Compress the cd, ls -l series of commands.
function cl () {
   if [ $# = 0 ]; then
      cd && l
   else
      cd "$*" && l
   fi
}
# Alias for common miss-type
alias lc="cl"

# Compress mkdir, and then cd'ing into it, into a single shortcut
function mc() {
  mkdir -p "$*" && cd "$*" && pwd
}

###############################################################################
# Rsync
#
# -a = --archive - Recursive, and preserve file attributes.
# -v = --verbose - List the files that are being transfered.
# -z = --compress - Compress data before the transfer.
# -h = --human-readable - Output file sizes in MB, GB, etc, not just bytes.
# --progress = Show the progress of the transfer so that we feel warm and fuzzy
# --exclude = Don't copy some files
#
###############################################################################
# TODO wrap this in a conditional for MacOS and only exclude .DS_Store on there
alias rsc='rsync -avzh --progress --exclude ".DS_Store"'

###############################################################################
# Extracting
###############################################################################
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

###############################################################################
# OS X Specific Tools
###############################################################################
#if [ $OS == 'mac' ]; then
#  # Replicate the tree function on OS X
#  # TODO - wrap this in a conditional
#  #        some of these flags are pretty OS X specific
#  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
#  # Copy curent directory to clipboard
#
#  # Quicker smaller top
#  # -R don't show memory
#  # -F don't show frameworks
#  # -s loop every two seconds
#  # -n show 30 processes
#  alias topp='top -ocpu -R -F -s 2 -n30'
#
#  # Copy curent directory to clipboard
#  alias cpwd='printf "%q\n" "$(pwd)" | pbcopy'
#
#  # Dump man pages to Preview
#  pman() {
#    man -t "${1}" | open -f -a /Applications/Preview.app/
#  }
#
#  # Aliases for MacVim if it exists
#  vipath=$(which mvim 2> /dev/null)
#  if [ ! -z $vipath  ] ; then
#    alias vi="mvim"
#    alias vim="mvim"
#  fi
#
#  # Easy command to start and stop PostgreSQL server
#  if [ -d /usr/local/var/postgres ] ; then
#    alias pgs='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
#    alias pgq='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
#  fi
#
#  # Correct puppet version
#  export PATH=/opt/puppetlabs/bin:$PATH
#
#fi

###############################################################################
# Vim
###############################################################################
# Aliases for MacVim if it exists
vipath=$(which mvim > /dev/null)
if [ ! -z $vipath  ] ; then
  alias vi="mvim"
#  alias vim="mvim"
fi

# ci is a command for the RCS VCS. I don't use it. But I often mistype vi
# as ci, so I'm aliasing it to prevent that.
alias ci="vi"


###############################################################################
# Git
###############################################################################
# Removing the -b flag
# It isn't supported until Git 1.7.2 which isn't common in CentOS and other
# Linux rpms just yet. So, removing this makes this bash profile a bit more
# portable for now.
# alias gs='git status -sb'
alias gs='git status -s'

alias gc='git commit -v'
alias ga='git add'
alias gap='git add -p'
# Common typo
alias gao='git add -p'
alias gapi='git -c interactive.diffFilter="git diff --color-words" add -p'
alias gaa='git add -A'
alias gco='git checkout'
alias gl='git log --oneline --decorate --color=always | less -R'
alias gd='git diff'
alias gdt='git difftool'
alias gps='git push'
alias gpsm='git push origin master'
alias gpsmt='git push origin master --tags'
alias gpsd='git push origin develop'
alias gpl='git pull'
alias gplm='git pull origin master'
alias gpld='git pull origin develop'
alias gf='git fetch'
alias gb='git branch'
alias gba='git branch -a -v -v'
alias gun='git reset HEAD'             # Unstage added changes
alias gbc='git checkout -b'
alias gsh='git stash save -u'
alias gshl='git stash list --date=relative'
# Delete branches that have been merged to master
alias gclean='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'
#alias git-permission-reset='!git diff -p -R | grep -E \"^(diff|(old|new) mode)\" | git apply'
alias not-git='git status --ignored'

###############################################################################
# Applications
###############################################################################
# Sourcetree
alias stree='/Applications/Sourcetree.app/Contents/Resources/stree'

# Opens the github page for the current git repository in your browser
# from https://github.com/jasonneylon/dotfiles/
function github() {
  giturl=$(git config --get remote.origin.url)
  if [ -z "$giturl" ]; then
    echo "Not a git repository or no remote.origin.url set"
  else
    giturl=${giturl/git\@github\.com\:/https://github.com/}
    giturl=${giturl/\.git//}
    echo $giturl
    open $giturl
  fi
}
alias gh='github'
# Shorter Terraform command
alias tf='terraform'

###############################################################################
# Networking
###############################################################################
# List all open ports where you are listening
# TODO: This is linux only. Add a wrapper
alias ports='netstat -tulpn | grep LISTEN'
# List open internet connections
alias net-open='lsof -i'
alias myip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'\"' '{ print $2}'"

###############################################################################
# Generate random files
###############################################################################
# TODO: write command to make a random text file
#alias gent =
alias geni='convert -size 100x100 xc: +noise Random random.png'

###############################################################################
# Reload config
###############################################################################
alias reload='source ~/.zshrc'

###############################################################################
# FASD
###############################################################################
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
# I used to use autojump instead of fasd. This helps me keep that alias memory.
alias j='fasd_cd -d'
alias v='f -e vim' # quick opening files with Vim
alias o='a -e open' # quick opening files with Finder
alias i='a -e idea' # quick opening files with IntelliJIDEA

###############################################################################
# Prompt
###############################################################################
## My custom prompt colors
#YELLOW="$FG[227]"
#PURPLE="$FG[177]"
#BLUE="$FG[117]"
#
#PROMPT_USERNAME="%n"
#PROMPT_HOSTNAME="%m"
#PROMPT_DIR="%c"
#PROMPT_CWD="%~"
#GIT_PROMPT='$(out=$(git_prompt_info)$(git_prompt_status)$(git_remote_status);if [[ -n $out ]]; then printf %s " $white($green$out$white)$reset";fi)'
#
#PROMPT='$PURPLE$PROMPT_USERNAME%{$reset_color%}@$YELLOW$PROMPT_HOSTNAME %{$reset_color%} $BLUE$PROMPT_CWD %{$reset_color%}
#'
#PROMPT+="$GIT_PROMPT
#"

# I'm trying the Pure prompt to see how it works for me.
autoload -U promptinit; promptinit
zstyle :prompt:pure:path color blue
zstyle :prompt:pure:user color magenta
zstyle :prompt:pure:host color yellow
prompt pure

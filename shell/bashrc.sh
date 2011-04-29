# ~/.bashrc

# Text color variables
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m' # Black - Background
bakred='\e[41m' # Red
badgrn='\e[42m' # Green
bakylw='\e[43m' # Yellow
bakblu='\e[44m' # Blue
bakpur='\e[45m' # Purple
bakcyn='\e[46m' # Cyan
bakwht='\e[47m' # White
txtrst='\e[0m' # Text Reset

# Custom Prompt
set_prompt_style () {
  # local bashuser="\[$bldgrn\]\u@\[$txtrst\]"
  # local bashhost="\[$bldgrn\]\h\[$txtrst\]"
  local bashid="\[$bldpur\]emach\[$txtrst\]" # or a general id
  local bashdir="\[$bldblu\]\w\[$txtrst\]"
  local bashprompt="\[$bldblk\]:\n\[$txtrst\]"

  if [ `whoami` == "root" ] ; then
    # local bashuser="\[$bldred\]\u@\[$txtrst\]"
    # local bashhost="\[$bldred\]\h\[$txtrst\]"
    local bashid="\[$bldred\]emach\[$txtrst\]" # or a general id
  fi
  PS1="$bashuser$bashhost$bashid $bashdir$bashprompt"
}
set_prompt_style

## Basic Settings ##

# Check for an interactive session
[ -z "$PS1" ] && return

# Editor
export EDITOR=vim
export VISUAL=vim # for crontab

# ls colors
eval `dircolors -b`

# grep colors
alias grep='grep --color=auto'
export GREP_COLOR="1;37"
#export GREP_COLOR="1;33"
#export GREP_COLOR="01;38;5;253"
#export GREP_COLOR="01;38;5;187" # Yellow

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\e[0m' # end mode
export LESS_TERMCAP_se=$'\e[0m' # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m' # end underline
export LESS_TERMCAP_us=$'\e[38;5;97m' # begin underline

# Path
export PATH="~/.bin:~/.bin/programs:~/.bin/root:~/.bin/root/arch:~/.bin/root/backup:~/.bin/root/debian:~/.bin/root/gentoo:$PATH"


## Aliases ##

# Bash Navigation/Tools
alias ls='ls --color=auto -X --group-directories-first' # add color, group dir
alias lsl='ls -lah' # long list, human-readable
alias lsd='ls -latr' # sort by date
alias lss='ls -shaxSr' # sort by size
alias ln="ln -s"
alias cpr="cp -r" # copy recursively
alias rmr="rm -r" # remove recursively
alias ebash="v ~/.bashrc"
alias sbash="source ~/.bashrc"

# Shortcuts
alias cda="cd /var/abs/local && ls -h"
if [ `whoami` == root ]; then
  alias cdb="cd /home/todd/.bin/root && ls -h"; else
  alias cdb="cd ~/.bin && ls -h"
fi
alias cdd="cd ~/Desktop && ls -h"
cdf () { cd "$(dirname "$(locate -i "$*" | head -n 1)")" ; } # locate then cd

  # System
  alias check-disks='shutdown -Fr now'
  alias unmount-all='umount -va'
  alias chot="chown -R todd:users"
  alias chx="chmod +x"
  alias cron="crontab -e"

  # Network
  alias pg="ping -c2 www.archlinux.org"

  # Everyting else
  alias v="vim -p"
  alias vi="vim"
  alias kernel-compile="make clean bzImage modules modules_install install"
  alias wget="wget -c"
  alias kwrite="bgcmd kwrite"


  ## Commands ##

  # Bash Completion
  complete -W "`awk '{ print $2 }' /etc/hosts`" ssh

  complete -o default -F _daemon daemon

  complete -cf sudo
  complete -cf kdesu
  complete -cf bgcmd
  complete -cf newx

  # rc autocompletion
  #_rc()
  #{
  # local cur prev
  # COMPREPLY=()
  # cur=${COMP_WORDS[COMP_CWORD]}
  # prev=${COMP_WORDS[COMP_CWORD-1]}
  # if [ "$prev" == service ]; then
  # COMPREPLY=( $(compgen -W "$(for rc in /etc/rc.d/*; do echo ${rc##*/}
  # done )" -- $cur ) ); else
  # COMPREPLY=( $(compgen -W ' start stop restart reload' -- $cur ) )
  # fi
  #}
  #complete -o default -F _rc rc

  _rc()
  {
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    if [ $COMP_CWORD -eq 1 ]; then
      COMPREPLY=( $( compgen -W "$(for i in /etc/rc.d/*; do echo ${i##*/}
    done)" $cur ) )
  elif [ $COMP_CWORD -eq 2 ]; then
    COMPREPLY=( $( compgen -W "start stop restart reload" $cur ) )
  fi
}

complete -o default -F _rc rc

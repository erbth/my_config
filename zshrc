# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=100000
setopt appendhistory autocd nomatch
unsetopt beep extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/therb/.zshrc'

autoload -Uz compinit
compinit

# History:
# fc -RI  load history file
# fc -AI  save to history file

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

case "$TERM" in
	xterm*|rxvt*) terminal_emulator_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

# if [ "$color_prompt" = yes ]; then
PROMPT='%B%F{green}%n@%m%f%b:%B%F{blue}%~%f%b%(?.%#.%B%F{red}%#%f%b) '
# else
#     PROMPT='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
unset color_prompt force_color_prompt

# Bash-style word navigation
autoload -U select-word-style
select-word-style bash

# host, cwd in terminal emulator title
if [ "$terminal_emulator_prompt" = yes ]
then
	precmd() {
		print -Pn "\e]0;%n@%m: %~\a"
	}
fi

# Skip words with arrow keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Environment vairables for Debain's maintainance tools
DEBEMAIL="t.erbesdobler@gmx.de"
DEBFULLNAME="Thomas Erbesdobler"
export DEBEMAIL DEBFULLNAME

# OPAM configuration
#. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

case $TERM in
    dumb)
        PS1='$ '
        unset zle
        ;;
esac

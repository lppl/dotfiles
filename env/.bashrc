#!/usr/bin/env bash
# 
# bashrc customization
#
# © 2012-2015 Łukasz Pietrek
# https://www.debian.org/legal/licenses/mit

run_if_interactive () {
  case $- in
      *i*) main_bashrc;;
        *) return;;
  esac
}

main_bashrc () {
  set_shell_variables
  modify_bash_behavior
  configure_prompt
  set_aliases
  enable_programmable_completion_features
  set_and_export_shell_variables
  load_local_settings
}


set_shell_variables () {
  HISTCONTROL=ignoreboth
  HISTSIZE=1000
  HISTFILESIZE=2000
}


modify_bash_behavior () {
  shopt -s checkwinsize
  shopt -s histappend
  shopt -s globstar
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
}


configure_prompt () {
  if [ -f ~/.bash_prompt ]; then
      . ~/.bash_prompt
  fi
}


set_aliases () {
  if [ -f ~/.bash_aliases ]; then
      . ~/.bash_aliases
  fi
}


enable_programmable_completion_features () {
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi
}


set_and_export_shell_variables () {
  export COLORFGBG="default;default"
  export EDITOR="vim"
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
}


load_local_settings () {
  if [ -f ~/.bashrc_local ]; then
      . ~/.bashrc_local
  fi
}


run_if_interactive


unset -f run_if_interactive
unset -f main_bashrc
unset -f set_shell_variables
unset -f modify_bash_behavior
unset -f configure_prompt
unset -f set_aliases
unset -f enable_programmable_completion_features
unset -f set_and_export_shell_variables
unset -f load_local_settings

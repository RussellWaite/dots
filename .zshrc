# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
unsetopt beep
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#trying out a more efficient path update (i.e. don't keep adding duplicates)
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

export GOPATH=$HOME/go
pathadd $GOPATH/bin
pathadd ~/bin
pathadd ~/bin/VSCode-linux-x64/bin
pathadd ${KREW_ROOT:-$HOME/.krew}/bin
pathadd ~/.cargo/bin
export EDITOR=nvim

# setup expected defaults for ohmyzsh based plugins (kubectl for completion)
if [[ -z "$ZSH" ]]; then
  ZSH=~/zsh
fi
if [[ -z "$ZSH_CACHE_DIR" ]]; then
  ZSH_CACHE_DIR="$ZSH/cache"
fi
mkdir -p $ZSH_CACHE_DIR

# find out how we got 256 colours - multiple strategies are used... chrissicool/zsh-256color
#ZSH_256COLOR_DEBUG=1

# fix for using powerlevel10k in tmux
#export TERM=screen-256color
export TERM="xterm-256color"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/dotfiles/.powerlevel10k_config.sh
alias colours='f(){ for i in {0..255}; do printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i ; if ! (( ($i + 1 ) % 8 )); then echo ; fi ; done; }; f'

alias lsx='exa -lhaTR --git'
alias start_i3='XDG_SESSION_TYPE=wayland dbus-run-session i3'
alias start_gnome='XDG_SESSION_TYPE=wayland dbus-run-session gnome-session'
# and finally - load the lovely plugins... quickly
# using Antibody static loading - https://getantibody.github.io/usage/
# remember to run `antibody bundle < .zsh_plugins.txt > .zsh_plugins.sh` when you update your plugins
source ~/.zsh_plugins.sh

source ~/dotfiles/helm_completions.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/nvm/init-nvm.sh
#compdef platformio
_platformio() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PLATFORMIO_COMPLETE=complete-zsh  platformio)
}
if [[ "$(basename -- ${(%):-%x})" != "_platformio" ]]; then
  compdef _platformio platformio
fi
#compdef pio
_pio() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIO_COMPLETE=complete-zsh  pio)
}
if [[ "$(basename -- ${(%):-%x})" != "_pio" ]]; then
  compdef _pio pio
fi

alias dotgit='/usr/bin/git --git-dir=$HOME/dots/ --work-tree=$HOME'
dotgit config --local status.showUntrackedFiles no

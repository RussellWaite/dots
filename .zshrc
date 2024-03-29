## profile zsh startup (1/2)
# zmodload zsh/zprof

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt share_history

unsetopt beep

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

#trying out a more efficient path update (i.e. don't keep adding duplicates)
# source: https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
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
pathadd ~/.dotnet/tools
pathadd ~/.local/bin
pathadd /usr/share/bcc/tools
pathadd /opt/flutter/bin
export EDITOR=nvim

# fix mutter/wayland/firefox bug that's REALLY annoying
export MOZ_ENABLE_WAYLAND=1
export XDG_CONFIG_HOME=$HOME/.config/
# setup expected defaults for ohmyzsh based plugins (kubectl for completion)
if [[ -z "$ZSH" ]]; then
  ZSH=~/zsh
fi
if [[ -z "$ZSH_CACHE_DIR" ]]; then
  ZSH_CACHE_DIR="$ZSH/cache"
fi
mkdir -p $ZSH_CACHE_DIR

eval "$(starship init zsh)"

alias colours='f(){ for i in {0..255}; do printf "\x1b[38;5;${i}mcolour%-5i\x1b[0m" $i ; if ! (( ($i + 1 ) % 8 )); then echo ; fi ; done; }; f'
alias lsx='eza -lhaTR --git'
alias start_i3='XDG_SESSION_TYPE=wayland dbus-run-session i3'
alias start_gnome='XDG_SESSION_TYPE=wayland dbus-run-session gnome-session'
alias krew='kubectl krew'
alias nc='ncat'
alias vim=nvim
alias ls='eza -alh --time-style long-iso --git'
alias myip='dig TXT ip.sslip.io @ns.sslip.io +short'
alias favs='cat ~/.histfile | cut -d" " -f1 | sort | uniq -c | sort -n'
alias re='r(){ rustc --explain $1 | bat -l rust --theme zenburn }; r' 
alias heat='watch -n 2 sensors'
alias cpu='watch -n 2 "cat /proc/cpuinfo | grep MHz"'
alias update_anitdote_plugins=' cd ~/.cache/antidote && ls  | xargs -I % echo "cd ~/.cache/antidote/% && git pull;" | sh'
alias pycode='code --enable-proposed-api ms-toolsai.jupyter'
alias prcode="code --enable-proposed-api GitHub.vscode-pull-request-github"
alias cat=bat

# and finally - load the lovely plugins... quickly
# updated to antidote as antigen is obsolete now.
# remember to run `antidote bundle < .zsh_plugins.txt > .zsh_plugins.sh` when you update your plugins
source ~/.zsh_plugins.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# how I can have files in my home dir that are versioned controlled 
# without having a .git folder in home and having to exclude everything 
# I don't want on github
alias dot='/usr/bin/git --git-dir=$HOME/dots/ --work-tree=$HOME'
dot config --local status.showUntrackedFiles no

# in zsh enables hiding history by using a leading space e.g. " cat .zshrc" will not be added to .histfile but "cat .zshrc" still will be
setopt HIST_IGNORE_SPACE

## profile zsh startup (2/2)
# zprof
# if [ -e /home/user6/.nix-profile/etc/profile.d/nix.sh ]; then . /home/user6/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

alias luamake=/home/user6/dev/lua/lua-language-server/3rd/luamake/luamake

# opam configuration
# [[ ! -r /home/user6/.opam/opam-init/init.zsh ]] || source /home/user6/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/usr/etc/profile.d/conda.sh" ]; then
#         . "/usr/etc/profile.d/conda.sh"
#     else
#         export PATH="/usr/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<


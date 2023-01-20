# zsh env
export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
[[ ! -d ${XDG_STATE_HOME:-$HOME/.local/state}/zsh ]] && mkdir -p ${XDG_STATE_HOME:-$HOME/.local/state}/zsh 
export HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/zsh_history
export _Z_DATA=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/z
[[ ! -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh ]] && mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}/zsh 
export ZSH_COMPDUMP=$XDG_CACHE_HOME/zsh/zcompdump-$HOST-$ZSH_VERSION

# add path
path=($HOME/.local/bin $path)

# environment
[[ ! $XDG_CONFIG_HOME ]] && export $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)


# zsh env
[[ ! -d ${XDG_STATE_HOME:-$HOME/.local/state}/zsh ]] && mkdir -p ${XDG_STATE_HOME:-$HOME/.local/state}/zsh 
export _Z_DATA=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/z

# add path
path=($HOME/.local/bin $path)

# environment
## for gpg ssh-agent see also: https://wiki.archlinuxcn.org/wiki/GnuPG#%E9%85%8D%E7%BD%AE_pinentry_%E4%BD%BF%E7%94%A8%E6%AD%A3%E7%A1%AE%E7%9A%84_TTY
export GPG_TTY=$(tty)

[[ ! $XDG_CONFIG_HOME ]] && export $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)


# zsh env
export _Z_DATA=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/z

# add path
typeset -U path
path=($HOME/.local/bin $HOME/.local/share/cargo/bin/ $path)

# environment
## for gpg ssh-agent see also: https://wiki.archlinuxcn.org/wiki/GnuPG#%E9%85%8D%E7%BD%AE_pinentry_%E4%BD%BF%E7%94%A8%E6%AD%A3%E7%A1%AE%E7%9A%84_TTY
## use $TTY is a much faster trick: https://github.com/romkatv/powerlevel10k/#how-do-i-export-gpg_tty-when-using-instant-prompt
export GPG_TTY=$TTY

[[ -z $XDG_SESSION_TYPE || $XDG_SESSION_TYPE == "tty" ]] && export $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)

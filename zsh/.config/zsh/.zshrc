# source zsh_unplugged
source $ZDOTDIR/zsh_unplugged_wirano.zsh

# Basic config

autoload -U compinit
compinit -D ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump


# History
HISTFILE=${XDG_STATE_HOME}/zsh/zsh_history
HISTSIZE=128000
SAVEHIST=128000
setopt hist_save_no_dups
setopt hist_ignore_dups
# add a space before a command to ignore history
setopt hist_ignore_space

# disable bell
unsetopt beep
# enter dir without cd
setopt autocd

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

# use comments in interactive mode
setopt interactive_comments

# complete "identifier=path" style arguments
setopt magic_equal_subst

# dirstack
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
      dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
        [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
      print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
  }

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus

# Plugins
plugins=(
    # use zsh-defer magic to load the remaining plugins at hypersonic speed!
    #romkatv/zsh-defer

    # core plugins
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-completions

    # user plugins
    rupa/z
    hlissner/zsh-autopair
    djui/alias-tips
    peterhurford/up.zsh

    # theme
    romkatv/powerlevel10k
    zdharma-continuum/fast-syntax-highlighting
)

files=(
    # ohmyzsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/common-aliases/common-aliases.plugin.zsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/extract/extract.plugin.zsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
)

# clone, source, and add to fpath
plugin-load $plugins
load-files $files

# plugin history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/p10k/p10k-instant-prompt-${(%):-%n}.zsh" ]] {
    source "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/p10k/p10k-instant-prompt-${(%):-%n}.zsh"
}

ZLE_RPROMPT_INDENT=0

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]] {
    export EDITOR='vim'
} else {
    export EDITOR='vim'
}

if [[ $TERM != linux ]] {
    source $ZPLUGINDIR/powerlevel10k/powerlevel10k.zsh-theme

    # To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
    [[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

    # https://wiki.archlinux.org/title/Tmux#Start_tmux_on_every_shell_login
    # if tmux is executable and not inside a tmux session, then try to attach.
    # if attachment fails, start a new session
    [[ -x $(command -v tmux) ]] \
        && [[ -z $TMUX ]] \
        && { tmux attach || tmux; } >/dev/null 2>&1
}


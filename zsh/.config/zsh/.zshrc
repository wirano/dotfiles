# source zsh_unplugged
source $ZDOTDIR/zsh_unplugged_wirano.zsh

# Basic config

autoload -U compinit
compinit


# History
HISTFILE=${XDG_STATE_HPME}/zsh/zsh_history
HISTSIZE='128000'
SAVEHIST='128000'
setopt hist_save_no_dups
setopt hist_ignore_dups
# add a space before a command to ignore history
setopt hist_ignore_space

setopt autocd

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

setopt interactive_comments

setopt magic_equal_subst

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

    zdharma-continuum/fast-syntax-highlighting
)

files=(
    # ohmyzsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/common-aliases/common-aliases.plugin.zsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/extract/extract.plugin.zsh
)

# clone, source, and add to fpath
plugin-load $plugins
load-files $files

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
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

    # To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
    [[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

    # https://wiki.archlinux.org/title/Tmux#Start_tmux_on_every_shell_login
    # if tmux is executable and not inside a tmux session, then try to attach.
    # if attachment fails, start a new session
    [[ -x $(command -v tmux) ]] \
        && [[ -z $TMUX ]] \
        && { tmux attach || tmux; } >/dev/null 2>&1
}


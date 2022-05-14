# zsh env
export ZDOTDIR=$HOME/.config/zsh
export HISTFILE=$HOME/.local/state/zsh/zsh_history
export ZSH_COMPDUMP=$XDG_CACHE_HOME/zsh/zcompdump-$HOST-$ZSH_VERSION
export _Z_DATA=$XDG_STATE_HOME/zsh/z

# add path
path=($HOME/.local/bin $path)

# Workarounds for XDG base directory
# # https://wiki.archlinux.org/title/XDG_Base_Directory#Partial
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
export ANDROID_SDK_ROOT=$XDG_DATA_HOME/android-sdk
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nvidia
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export GOPATH=$XDG_DATA_HOME/go
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export GTK_RC_FILES=$XDG_CONFIG_HOME/gtk-1.0/gtkrc-1.0
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0
export IDF_TOOLS_PATH=$XDG_DATA_HOME/esp-idf-tools
export IPYTHONDIR=$XDG_DATA_HOME/ipython
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export KDEHOME=$XDG_CONFIG_HOME/kde4
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export VSCODE_PORTABLE=$XDG_DATA_HOME/vscode
export WGETRC=$XDG_CONFIG_HOME/wget/config.ini


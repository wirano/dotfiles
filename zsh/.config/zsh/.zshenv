export ZDOTDIR=$HOME/.config/zsh

export HISTFILE=$HOME/.local/state/zsh/zsh_history

export ZSH_COMPDUMP=$XDG_CACHE_HOME/zsh/zcompdump-$HOST-$ZSH_VERSION

export _Z_DATA="$XDG_STATE_HOME"/zsh/z

# .kde4 for KDE config
export KDEHOME="$XDG_CONFIG_HOME"/kde4

# .gtkrc-2.0 fot GTK 2
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtkrc-2.0

# .java for openjdk
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# .android for adb
export ANDROID_SDK_ROOT=$XDG_DATA_HOME/android

# .bash_history
#export HISTFILE=$XDG_DATA_HOME/bash/history

# .npmrc for NPM
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode

export IDF_TOOLS_PATH="$XDG_DATA_HOME"/esp-idf-tools

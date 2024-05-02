#! /bin/sh
#
# bwrap_gui_common.sh
# Copyright (C) 2024 wirano <git@wirano.me>
#
# Distributed under terms of the MIT license.
#


#https://blog.lilydjwg.me/2021/8/12/using-bwrap.215869.html


bwrap_gui_common(){
    bwrap \
    --unshare-all --share-net --cap-drop ALL --die-with-parent --new-session \
    --ro-bind / / \
    --hostname "$(hostname)" \
    --tmpfs /sys --tmpfs /home --tmpfs /tmp --tmpfs /run --proc /proc \
    --dev-bind /dev /dev \
    --ro-bind /run/systemd/resolve /run/systemd/resolve \
    `# wayland proxy needs rw premission to create socket` \
    --bind "${XDG_RUNTIME_DIR}" "${XDG_RUNTIME_DIR}" \
    --bind "${XDG_CONFIG_HOME}" "${XDG_CONFIG_HOME}" \
    --bind "${XDG_CACHE_HOME}" "${XDG_CACHE_HOME}" \
    --bind "${XDG_DATA_HOME}" "${XDG_DATA_HOME}" \
    --ro-bind ~/dotfiles ~/dotfiles \
    --ro-bind "${XDG_CONFIG_HOME}"/mimeapps.list "${XDG_CONFIG_HOME}"/mimeapps.list \
    --ro-bind "${XDG_CONFIG_HOME}"/fontconfig "${XDG_CONFIG_HOME}"/fontconfig \
    --chdir ~ \
    "$@"
}

set -gx DEV_ENV_DIR "$HOME/utils/dotfiles"
set -gx QMK_HOME "$HOME/utils/qmk_firmware"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx PATH "$HOME/bin" "$HOME/.local/bin" $PATH

set -gx EDITOR vim
set -gx VISUAL vim

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual blockacter

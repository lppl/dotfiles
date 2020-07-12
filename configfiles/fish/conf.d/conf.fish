fish_vi_key_bindings

set -gx PATH $PATH ~/.npm-packages/bin ~/.local/bin
set -gx EDITOR /usr/bin/vim


# Setup theme

set -g default_user your_normal_user
set -g fish_prompt_pwd_dir_length 0

set -g theme_color_scheme dark

set -g theme_avoid_ambiguous_glyphs yes
set -g theme_date_format "+%a %H:%M"
set -g theme_display_cmd_duration yes
set -g theme_display_date no
set -g theme_display_docker_machine no
set -g theme_display_git yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_untracked yes
set -g theme_display_hg yes
set -g theme_display_ruby no
set -g theme_display_user yes
set -g theme_display_vagrant yes
set -g theme_display_vi yes
set -g theme_display_virtualenv no
set -g theme_git_worktree_support yes
set -g theme_nerd_fonts yes
set -g theme_powerline_fonts no
set -g theme_project_dir_length 1
set -g theme_show_exit_status yes
set -g theme_title_display_path no
set -g theme_title_display_process yes
set -g theme_title_use_abbreviated_path no

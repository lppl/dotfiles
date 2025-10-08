function _tide_item_character
    set -q add_prefix || echo -ns ' '

    if not test "$fish_key_bindings" = fish_default_key_bindings
        switch $fish_bind_mode
        case insert
            set _vi_mode_color green
            set _vi_mode_character $tide_character_icon
        case default
            set _vi_mode_color yellow
            set _vi_mode_character $tide_character_vi_icon_default
        case replace replace_one
            set _vi_mode_color magenta
            set _vi_mode_character $tide_character_vi_icon_replace
        case visual
            set _vi_mode_color blue
            set _vi_mode_character $tide_character_vi_icon_visual
        end
        set_color $_vi_mode_color
        echo -ns [$_vi_mode_character]
    end

    if test $_tide_status != 0
        set_color $tide_character_color_failure
        echo -ns "!!!"
    else
        set_color $tide_character_color
        echo -ns " \$ "
    end
end

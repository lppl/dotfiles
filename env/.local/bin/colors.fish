function color_set --argument-names color_var --description 'Set color from current Fish theme'
  set -l style

  if set -q $color_var
    set style $$color_var
  end


  if not set_color $style 2>/dev/null
    echo "[[No color for style '$color_var']]"
  end
end

function color_reset --description 'Reset terminal color'
  set_color normal
end

function color_text --argument-names color_var --description 'Print colored text without newline'
  set -l message $argv[2..-1]

  color_set $color_var 
  if test (count $message) -gt 0
    printf '%s' (string join ' ' -- $message)
  end
  color_reset
end

function color_print --argument-names label color_var --description 'Print colored labeled message'
  set -l message $argv[3..-1]

  color_set $color_var 
  if test (count $message) -gt 0
    printf '[%s] %s' $label (string join ' ' -- $message)
  else
    printf '[%s]' $label
  end
  color_reset
  printf '\n'
end

function color_log --description 'Print log message'
  color_print log fish_color_command $argv
end

function color_success --description 'Print success message'
  color_print success fish_color_cwd $argv
end

function color_error --description 'Print error message'
  color_print error fish_color_error $argv >&2
end

function color_debug --description 'Print debug message'
  color_print debug fish_color_comment $argv
end

function color_info --description 'Print info message'
  color_print info fish_color_param $argv
end

function log_msg --description 'Print log message'
  color_log $argv
end

function log_success --description 'Print success message'
  color_success $argv
end

function log_error --description 'Print error message'
  color_error $argv
end

function log_debug --description 'Print debug message'
  color_debug $argv
end

function log_info --description 'Print info message'
  color_info $argv
end

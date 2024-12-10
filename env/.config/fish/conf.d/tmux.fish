if test -z "$TMUX"; and test "$TERM" = "xterm-kitty";
  tmux attach || exec tmux new-session && exit;
end

set -gx PNPM_HOME /home/lppl/.local/share/pnpm
set -l OWN /home/lppl/bin
set -l CARGO /home/lppl/.cargo/bin
set -l BUN /home/lppl/.bun/bin
set -l LOCAL /home/lppl/.local/bin
set -l GO /usr/local/go/bin

for path in $OWN $PNPM_HOME $CARGO $BUN $LOCAL
  if not contains $path $PATH
    set -gx PATH $PATH $path
  end
end

bash "$HOME/.cargo/env"

set -gx EDITOR vim
set -gx VISUAL vim

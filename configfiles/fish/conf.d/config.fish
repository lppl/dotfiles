set -gx PNPM_HOME /home/lppl/.local/share/pnpm

set -l OWN /home/lppl/bin

for path in $OWN $PNPM_HOME
  if not contains $path $PATH
    set -gx PATH $PATH $path
  end
end

bash "$HOME/.cargo/env"

set -gx EDITOR vim

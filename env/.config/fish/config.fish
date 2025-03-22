if status is-interactive
end


# node + nvm
set --universal nvm_default_version "v22"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

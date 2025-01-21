# dotfiles

Linux personal dotfiles.

Developed on and tested for Ubuntu 24.04 lts. Works fine also on wsl2.

### Main features

#### `tmux-sessionizer`

- in tmux is trigerred by ctr-b ctr-b shortcut
- is in path, can take folder `tmux-sessionizer ~/utils/dotfiles`
- list of directories can `.tmux-sessionizer-dirs` files, deafult is home
  direcotry

#### `dev-commit`

One command to hastly commit and push code. Uses current branch Can be
customized with [.dev-commit](`.dev-commit`) placed at repo root. Bare
`dev-commit` creates commit message, `dev-commit "Developer diary"` uses
provided explanation.

#### `dev-env --exec`

Copies configuration files into `$HOME/.config`, `$HOME/.local`.

#### Status lines

This is WIP. Idea is to split responsibiliestes between status lines of nvim,
fish and tmux.

#### Jetbrains like experience

Big WIP.

### Instalation

No single command survived for longer. Sad. Follow this recipe and deal with
entropy when required.

- Make sure to run on Ubuntu based system
- Look into recipes directory for inspiration
- For basic functionality follow:

  ```bash
  mkdir -p $HOME/utils
  export DEV_ENV_DIR="$HOME/utils/dotfiles"

  git clone https://github.com/lppl/dotfiles $DEV_ENV_DIR

  cd $DEV_ENV_DIR

  ./recipes/libs
  ./recipes/fish
  ./recipes/fisher
  ./recipes/luarocks
  ./recipes/neovim
  ./recipes/tmux

  ./env/.local/bin/dev-env --exec


  fish

  echo "utils/dotfiles" > $HOME/.tmux-sessionizer-dirs

  tmux-sessionizer .
  ```

### Roadmap

- [ ] Translate all scripts in env/.local/bin into fish

# Repository Guidelines

## Project Structure & Module Organization

- Neovim Lua config. 
- `init.lua` = entry point for startup wiring and core options. 
- `plugin/` = plugin setup, ordered by numeric prefixes (`20_lsp.lua`, `90_keymaps.lua`) to show load order. 
- `lua/` = reusable modules (`lua/keymap.lua`, `lua/display.lua`). 
- `lsp/` = language server overrides. `nvim-pack-lock.json` = plugin lock state; edit only when plugin versions intentionally change.

## Build, Test, and Development Commands

No build step. Main checks:

```sh
nvim --headless "+checkhealth" +qa
```

Run Neovim health checks.

```sh
nvim --headless -u init.lua +qa
```

Verify config loads without startup errors.

```sh
stylua .
luacheck .
```

Format Lua via `stylua.toml`; lint via `.luacheckrc`.

## Coding Style & Naming Conventions

- Use `stylelua.toml` for format info.
- Plugin files: two-digit prefix + short feature name, e.g. `65_status.lua`. 
- Module files: lower_snake_case under `lua/`. 
- Keep changes scoped to affected plugin/module; avoid broad config reshuffles.

## Testing Guidelines

- No dedicated test suite. 
- For every change, run headless startup check. 
- Run `luacheck .` and to output
- For plugin, LSP, keymap, or autocmd changes, verify manually in real Neovim buffer.
- Run `stylua .` to format changes 

## Agent-Specific Instructions

- Preserve numeric plugin order. 
- `nvim-pack-lock.json` is immutable. 
- When adding external tools, note required binary in relevant plugin file or PR notes.

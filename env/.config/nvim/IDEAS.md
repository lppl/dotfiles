# Blink Integration Ideas

These are follow-up ideas for integrating `blink.cmp` with the existing Neovim plugin setup. Keep this list as a parking lot: only implement an item when it clearly improves the editing workflow.

- [ ] TODO: CodeCompanion: set `interactions.chat.opts.completion_provider = "blink"` in `plugin/80_codecompanion.lua` so chat completions consistently use blink for slash commands, editor context, and tools.
- [ ] TODO: Render Markdown: keep the existing LSP completion setup in `plugin/41_markown.lua`; it already works with blink, so no extra config is needed unless completions stop appearing.
- [ ] TODO: Noice cmdline: consider enabling blink cmdline ghost text or auto-show behavior if command-line completion should be more visible with `noice.nvim`.
- [ ] TODO: Copilot: consider adding `fang2hou/blink-copilot` only if Copilot suggestions should appear inside the blink menu; disable normal Copilot suggestions to avoid duplicate UI.
- [ ] TODO: Tmux: consider a `blink-cmp-tmux` source only if completions from tmux panes or tmux commands would be useful day to day.
- [ ] TODO: LazyDev: consider adding `folke/lazydev.nvim` for better Lua `require(...)` and module completions when editing this Neovim config.
- [x] TODO: LuaSnip: add `L3MON4D3/LuaSnip` and set blink's snippet preset to `luasnip` in `plugin/19_blink.lua`.

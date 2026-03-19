# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using Lua, managed with [Lazy.nvim](https://github.com/folke/lazy.nvim). The config follows a modular architecture with clear separation of concerns.

## Architecture

**Entry point**: `init.lua` — sets leader key (`<space>`), configures globals, then requires all core modules in order.

**Core modules** (`lua/`):
- `options.lua` — editor settings (tabs=4 spaces, ripgrep, fold, etc.)
- `mappings.lua` — all keybindings (100+)
- `plugins.lua` — Lazy.nvim plugin declarations
- `autocmds.lua` — auto commands for file type behavior, sessions, formatting
- `commands.lua` — custom user commands (`:Note`, `:Z`, `:SaveSession`, etc.)
- `colorscheme.lua` — custom light theme (GitHub Light palette)
- `globals.lua` — global utilities, project-local config loader
- `filetypes.lua` — file type associations

**Plugin configs** (`lua/x/`): Each plugin has a dedicated module exporting a `setup()` function, loaded from `plugins.lua`.

## Plugin System

Plugins are declared in `lua/plugins.lua` and lazy-loaded where possible. Plugin-specific config lives in `lua/x/<plugin>.lua`. The pattern is:

```lua
-- lua/x/myplugin.lua
local M = {}
M.setup = function() ... end
return M
```

To add a plugin: add its spec to `lua/plugins.lua` and create `lua/x/<plugin>.lua` if it needs configuration.

## Key Plugins

- **LSP**: nvim-lspconfig + mason (lua, go, ts, python, rust, c/cpp, vue, bash)
- **Completion**: nvim-cmp + luasnip
- **Syntax**: nvim-treesitter
- **Search**: Telescope + fzf-native
- **File explorer**: Oil.nvim (`-` key)
- **Git**: Gitsigns + LazyGit (`\g`)
- **Formatting**: Conform.nvim (goimports/gofmt for Go, prettier for JS/TS/HTML/CSS/JSON/YAML, black for Python)
- **Debug**: nvim-dap
- **REST client**: Kulala (`.http` files)
- **Jump**: Hop (`<leader>j`)

## Project-local Configuration

Each project can have a local Lua config stored in `~/.local/share/nvim/data/project_configs/`. This is loaded via `globals.lua` → `project_config.lua` on startup. It supports per-project telescope ignore patterns and init hooks.

## Session Management

Sessions are auto-saved on `VimLeave` (stored in `~/.local/share/nvim/sessions/`). Breakpoints are also persisted separately. Load with `\s` or `:LoadSession`.

## Notable Keymaps

| Key | Action |
|-----|--------|
| `<leader>f` | Find files (Telescope) |
| `<leader>g` | Live grep |
| `<leader>G` | Grep current word |
| `<leader>b` | Find buffers |
| `<leader>j` | Jump to char (Hop) |
| `gd` | Go to definition |
| `<leader>a` | Code action |
| `<leader>r` | References |
| `<leader>R` | Rename |
| `-` | Open Oil (file explorer) |
| `\g` | Open LazyGit |
| `\f` / `\F` | Copy file path (relative/absolute with line:col) |
| `\s` | Load default session |
| `\t` / `\T` | Open terminal (current dir / root dir) |
| `<F5>` | DAP continue/start |
| `<F7>` / `<F8>` | DAP step into / step over |
| `<leader>8` | Toggle breakpoint |

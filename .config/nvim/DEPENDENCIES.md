# Dependencies

> Everything needed to use this Neovim configuration on a fresh system.

---

## Neovim

| Requirement | Version |
|-------------|---------|
| Neovim | **0.11+** |

Uses `vim.pack.add`, `vim.lsp.enable`, and `vim._core.ui2` — all require Neovim 0.11 or later.

---

## System Packages

Install these with your system package manager (`apt`, `brew`, `dnf`, `pacman`, etc.).

### Required

| Binary | Package(s) | Used by |
|--------|------------|---------|
| `git` | `git` | neogit, gitsigns, diffview |
| `fzf` | `fzf` | fzf-lua (fuzzy finder) |
| `rg` | `ripgrep` | Typst ftplugin (search) |
| `xdg-open` | `xdg-utils` | Opening binary/image files externally |
| `trash` | `trash-cli` | oil.nvim (`delete_to_trash = true`) |
| `make` | `build-essential` / `make` | C compilation (`:make`) |
| `java` + `javac` | `jdk` / `java-devel` | jdtls (Java LSP) |
| `node` | `nodejs` | Firefox DAP adapter runner |
| `python3` | `python3` | debugpy, ruff, djlint, gdtoolkit |
| `rustc` + `cargo` | `rust` / `rustup` | Building `blink.cmp` native (Rust) component |

### Optional

| Binary | Package(s) | Used by |
|--------|------------|---------|
| `typst` | `typst` | Typst auto-compilation |
| `firefox` | `firefox` | JavaScript debugging via DAP |
| `stack` | `haskell-stack` | Haskell debugging |
| `hlint` | `hlint` | Haskell linting (can install via Mason instead) |

---

## Font

A **Nerd Font** is recommended (blink.cmp uses `nerd_font_variant = "mono"`).  
Install any patched font from [nerdfonts.com](https://www.nerdfonts.com/) (e.g. `JetBrainsMono Nerd Font`).

---

## Mason Packages (Language Servers, Formatters, Linters, Debuggers)

Installed automatically via `:MasonInstallAll` after starting Neovim.

### Language Servers

| Package | Language |
|---------|----------|
| `ty` | Typst |
| `clangd` | C / C++ |
| `jdtls` | Java |
| `haskell-language-server` | Haskell |
| `lua-language-server` | Lua |
| `biome` | JS / TS / JSON / CSS / HTML |
| `typescript-language-server` | TypeScript / JavaScript |
| `tailwindcss-language-server` | Tailwind CSS |
| `svelte-language-server` | Svelte |

### Formatters

| Package | Language |
|---------|----------|
| `ruff` | Python |
| `djlint` | Django HTML |
| `clang-format` | C, C++, Java |
| `fourmolu` | Haskell |
| `stylua` | Lua |
| `biome` | JS / TS / JSX / TSX / JSON / HTML / CSS / Svelte |
| `prettierd` | Markdown |
| `gdtoolkit` | GDScript (includes `gdformat`) |

Additional formatters used (non-Mason):
- `tex-fmt` — LaTeX (system binary)
- `prettypst` — Typst (system binary or Mason)
- SWI-Prolog formatter — Prolog (bundled with SWI-Prolog)

### Linters

| Package | Language |
|---------|----------|
| `ruff` | Python |
| `djlint` | Django HTML |
| `cpplint` | C, C++ |
| `hlint` | Haskell |
| `biome` | JS / TS / JSX / TSX / JSON / HTML / CSS / Svelte |
| `gdtoolkit` | GDScript (includes `gdlint`) |

### Debug Adapters

| Package | Used for |
|---------|----------|
| `debugpy` | Python debugging |
| `codelldb` | Rust / C / C++ debugging |
| `haskell-debug-adapter` | Haskell debugging |
| `js-debug-adapter` | JavaScript / TypeScript debugging |
| `firefox-debug-adapter` | Firefox browser debugging |
| `java-debug-adapter` | Java debugging |
| `java-test` | Java test running |

---

## Treesitter Parsers

Installed via `:TSInstallAll`. 25 parsers are configured:

`c`, `cpp`, `css`, `gdscript`, `groovy`, `haskell`, `htmldjango`, `html`, `java`, `javascript`, `json`, `lua`, `python`, `markdown`, `markdown_inline`, `query`, `svelte`, `tsx`, `typescript`, `typst`, `vim`, `vimdoc`, `yaml`, `prolog`, `bash`

---

## Plugins

All plugins are managed by Neovim's built-in `vim.pack.add` — they install automatically on first launch. No external plugin manager is needed.

### Plugin List

| Plugin | Repository |
|--------|------------|
| marko.nvim (minimap) | `mohseenrm/marko.nvim` |
| lazydev.nvim (Lua LSP annotations) | `folke/lazydev.nvim` |
| mason.nvim (package manager) | `mason-org/mason.nvim` |
| nvim-lspconfig (LSP client configs) | `neovim/nvim-lspconfig` |
| nvim-jdtls (Java LSP extension) | `mfussenegger/nvim-jdtls` |
| blink.cmp (completion engine) | `saghen/blink.cmp` |
| blink.lib (Rust native lib) | `saghen/blink.lib` |
| blink-cmp-spell (spell source) | `ribru17/blink-cmp-spell` |
| LuaSnip (snippet engine) | `L3MON4D3/LuaSnip` |
| friendly-snippets (snippet collection) | `rafamadriz/friendly-snippets` |
| nvim-treesitter | `nvim-treesitter/nvim-treesitter` |
| mini.nvim (sessions, hipatterns) | `nvim-mini/mini.nvim` |
| conform.nvim (formatter) | `stevearc/conform.nvim` |
| nvim-lint (linter) | `mfussenegger/nvim-lint` |
| fzf-lua (fuzzy finder) | `ibhagwan/fzf-lua` |
| oil.nvim (file browser) | `stevearc/oil.nvim` |
| neogit (git UI) | `NeogitOrg/neogit` |
| gitsigns.nvim (git decorations) | `lewis6991/gitsigns.nvim` |
| diffview.nvim (git diff viewer) | `sindrets/diffview.nvim` |
| modus-themes.nvim | `miikanissi/modus-themes.nvim` |
| neogen (annotation generator) | `danymat/neogen` |
| nvim-dap (debug adapter protocol) | `mfussenegger/nvim-dap` |
| nvim-dap-python (Python DAP) | `mfussenegger/nvim-dap-python` |
| nvim-dap-view (DAP UI) | `igorlfs/nvim-dap-view` |
| orgmode (Org-mode for Neovim) | `nvim-orgmode/orgmode` |

Built-in plugins (no install needed):
- `nvim.undotree`
- `nvim.difftool`

---

## Quick Setup

```bash
# 1. Install system packages (example for Debian/Ubuntu)
sudo apt install neovim git fzf ripgrep xdg-utils trash-cli build-essential \
                 default-jdk nodejs python3 rustup

# 2. Install Nerd Font (optional but recommended)
#    Download from https://www.nerdfonts.com/

# 3. Open Neovim — plugins install automatically
nvim

# 4. Install Mason packages (LSPs, formatters, linters, debuggers)
:MasonInstallAll

# 5. Install Treesitter parsers
:TSInstallAll
```

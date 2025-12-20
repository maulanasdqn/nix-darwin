# nix-darwin

My personal macOS configuration using nix-darwin, home-manager, and nixvim.

## Structure

```
.
├── flake.nix                       # Main entry point
├── flake.lock
├── config.nix                      # User configuration (git-ignored)
├── config.example.nix              # Example configuration
├── .envrc                          # Direnv integration
└── modules/
    ├── nix.nix                     # Nix/Determinate settings
    ├── darwin/
    │   ├── default.nix             # Darwin module entry
    │   ├── defaults/
    │   │   ├── default.nix         # Defaults entry
    │   │   ├── dock.nix            # Dock settings
    │   │   ├── finder.nix          # Finder settings
    │   │   └── global.nix          # Global macOS settings
    │   ├── fonts/
    │   │   └── default.nix         # Nerd Fonts
    │   ├── homebrew/
    │   │   └── default.nix         # Homebrew casks & brews
    │   ├── packages/
    │   │   └── default.nix         # System packages
    │   ├── security/
    │   │   └── default.nix         # Touch ID, sudo
    │   └── system/
    │       └── default.nix         # System settings
    └── home/
        ├── default.nix             # Home-manager entry
        ├── docker/
        │   └── default.nix         # Colima & Docker
        ├── git/
        │   └── default.nix         # Git configuration
        ├── laravel/
        │   └── default.nix         # PHP, Composer, databases
        ├── neovim/
        │   ├── default.nix         # Neovim entry
        │   ├── keymaps.nix         # Key mappings
        │   ├── options.nix         # Editor options
        │   └── plugins/
        │       ├── default.nix     # Plugins entry
        │       ├── colorscheme.nix # Rose-pine theme
        │       ├── cmp.nix         # Autocompletion
        │       ├── formatting.nix  # Formatters & autopairs
        │       ├── lsp.nix         # Language servers
        │       ├── telescope.nix   # Fuzzy finder
        │       ├── treesitter.nix  # Syntax highlighting
        │       └── ui.nix          # UI components
        ├── packages/
        │   └── default.nix         # CLI tools
        ├── starship/
        │   └── default.nix         # Starship prompt
        ├── tmux/
        │   ├── default.nix         # Tmux entry
        │   ├── keybindings.nix     # Tmux keybindings
        │   └── theme.nix           # Rose-pine theme
        └── zsh/
            ├── default.nix         # Zsh entry
            └── aliases.nix         # Shell aliases
```

## What's Included

### System (darwin)
- Touch ID for sudo
- Passwordless sudo
- Nerd Fonts (JetBrains Mono, Fira Code, Meslo)
- macOS defaults (dock, finder, keyboard)
- Homebrew integration

### Development

#### Languages & Runtimes
- **PHP 8.3** with Laravel extensions (composer, phpactor, php-cs-fixer)
- **TypeScript/JavaScript** via Volta, Bun, Deno
- **Rust** via rustup with rustaceanvim
- **Lua** with stylua formatter
- **Nix** with nil LSP and nixfmt

#### Databases
- MySQL (via Homebrew)
- PostgreSQL 16 (via Homebrew)
- Redis (via Homebrew)

#### Docker
- Colima (Docker runtime for macOS)
- Docker client & docker-compose

### Shell (zsh)
- Oh-My-Zsh with git, z, docker plugins
- Starship prompt
- Zoxide, fzf integration
- Syntax highlighting & autosuggestions
- Useful aliases for git, docker, php artisan

### Editor (neovim via nixvim)
- Rose-pine theme
- Full LSP support:
  - PHP (phpactor)
  - TypeScript/JavaScript (ts_ls, eslint)
  - Rust (rustaceanvim)
  - Tailwind CSS, HTML, CSS, JSON
  - Lua, Nix
- Treesitter with context
- Telescope fuzzy finder
- Neo-tree file explorer
- Git signs, lualine, which-key
- Autocompletion with nvim-cmp
- Format on save

### Terminal (tmux)
- Rose-pine theme
- Vim-like navigation
- Mouse support
- Custom keybindings with `Ctrl+a` prefix

### Tools
- ripgrep, fd, fzf, eza, bat, jq, tree
- Volta (Node.js version manager)
- Ghostty terminal
- Postman

## Installation

### Prerequisites
- macOS on Apple Silicon
- [Determinate Nix](https://determinate.systems/posts/determinate-nix-installer)

### Setup

```bash
# Clone the repo
git clone git@github.com:maulanasdqn/nix-darwin.git ~/.config/nix
cd ~/.config/nix

# Create your configuration
cp config.example.nix config.nix

# Edit config.nix with your settings
nvim config.nix

# Build and apply
nix develop --command rebuild
```

## Configuration

Edit `config.nix` to customize your setup:

```nix
{
  # Your macOS username
  username = "your-username";

  # Enable/disable Laravel development environment
  enableLaravel = true;

  # SSH public keys for authorized_keys
  sshKeys = [
    "ssh-ed25519 AAAAC3Nza... user@example.com"
  ];
}
```

| Option | Type | Description |
|--------|------|-------------|
| `username` | string | Your macOS username |
| `enableLaravel` | bool | Enable PHP, Composer, MySQL, PostgreSQL, Redis |
| `sshKeys` | list | SSH public keys for `~/.ssh/authorized_keys` |

## Secrets Management

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix) using age encryption.

### Setup

```bash
# Your age key is at ~/.config/sops/age/keys.txt
# Public key is in .sops.yaml

# Edit secrets (will decrypt, open editor, re-encrypt)
sops secrets/secrets.yaml
```

### Available Secrets

| Secret | Location |
|--------|----------|
| `github_token` | `~/.config/sops-nix/secrets/github_token` |
| `openai_api_key` | `~/.config/sops-nix/secrets/openai_api_key` |
| `anthropic_api_key` | `~/.config/sops-nix/secrets/anthropic_api_key` |
| `database_password` | `~/.config/sops-nix/secrets/database_password` |
| `ssh_private_key` | `~/.ssh/id_ed25519` (symlinked) |

### Adding Your SSH Private Key

```bash
# Edit secrets (opens in $EDITOR)
cd ~/.config/nix
sops secrets/secrets.yaml

# Replace the placeholder with your actual key:
ssh_private_key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  your-actual-key-content-here
  -----END OPENSSH PRIVATE KEY-----

# Save and rebuild
rebuild
```

### Adding New Secrets

1. Edit `secrets/secrets.yaml`:
   ```bash
   sops secrets/secrets.yaml
   ```

2. Add the secret to `modules/home/sops/default.nix`:
   ```nix
   secrets = {
     my_new_secret = { };
   };
   ```

3. Rebuild: `rebuild`

## Usage

```bash
# Rebuild after making changes
cd ~/.config/nix
nix develop --command rebuild

# Or with direnv enabled
rebuild
```

## Keybindings

### Neovim

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<leader>e` | Toggle file tree |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `gd` | Go to definition |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Hover docs |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>f` | Format |
| `[d` / `]d` | Prev/next diagnostic |

### Tmux

| Key | Action |
|-----|--------|
| `Ctrl+a` | Prefix key |
| `prefix + \|` | Vertical split |
| `prefix + -` | Horizontal split |
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + H/J/K/L` | Resize panes |
| `prefix + r` | Reload config |

## Shell Aliases

### Docker
| Alias | Command |
|-------|---------|
| `dc` | docker-compose |
| `dps` | docker ps |
| `dex` | docker exec -it |

### Laravel/PHP
| Alias | Command |
|-------|---------|
| `pa` | php artisan |
| `pas` | php artisan serve |
| `pam` | php artisan migrate |
| `pamfs` | php artisan migrate:fresh --seed |
| `ci` | composer install |
| `cu` | composer update |

### Git
| Alias | Command |
|-------|---------|
| `gs` | git status |
| `ga` | git add |
| `gc` | git commit |
| `gp` | git push |
| `gl` | git pull |
| `gco` | git checkout |
| `gcb` | git checkout -b |

## License

MIT

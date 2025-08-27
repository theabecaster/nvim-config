# Complete Setup Guide for Neovim Configuration

This guide will help you replicate this Neovim configuration on a new MacBook with zero errors.

## Prerequisites Check

Before starting, ensure you have:
- macOS (tested on Darwin 24.6.0)
- Terminal access
- Internet connection
- Admin privileges (for Homebrew installations)

## Step-by-Step Installation

### Step 1: Install Homebrew (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH (for Apple Silicon Macs)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

# For Intel Macs
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/usr/local/bin/brew shellenv)"
```

### Step 2: Install Core Dependencies

```bash
# Install essential tools
brew install git neovim ripgrep fd node npm python3

# Install a Nerd Font (required for icons)
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# Optional but recommended
brew install tmux  # For tmux-sessionizer functionality
```

### Step 3: Create Required Directories

```bash
# Create Neovim config directory
mkdir -p ~/.config

# Create undo directory for persistent undo
mkdir -p ~/.vim/undodir

# Create Packer directory
mkdir -p ~/.local/share/nvim/site/pack/packer/start
```

### Step 4: Clone Your Configuration

```bash
# Remove any existing Neovim config (backup first if needed)
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null

# Clone your configuration
cd ~/.config
git clone https://github.com/theabecaster/nvim-config.git nvim
```

### Step 5: Install Packer (Plugin Manager)

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Step 6: Install Python Providers

```bash
# Install Python providers for Neovim
pip3 install --user pynvim
npm install -g neovim
```

### Step 7: Initial Neovim Setup

```bash
# Open Neovim (ignore initial errors - this is normal)
nvim

# Once in Neovim, run these commands in order:
# 1. Source the Packer configuration
:source ~/.config/nvim/lua/theabecaster/packer.lua

# 2. Install all plugins (this will take a few minutes)
:PackerSync

# 3. Quit and restart Neovim
:q
```

### Step 8: Install Formatters

```bash
# Install code formatters
brew install stylua           # Lua formatter
pip3 install --user black isort  # Python formatters
npm install -g prettier        # JS/TS/JSON formatter

# Rust formatter (if you have Rust installed)
rustup component add rustfmt 2>/dev/null || echo "Rust not installed, skipping rustfmt"

# Go formatter comes with Go installation
brew install go  # If not already installed
```

### Step 9: Install Swift Support (Optional)

```bash
# Only if you need Swift development
xcode-select --install  # Install Xcode Command Line Tools
# SourceKit-LSP comes with Xcode
```

### Step 10: Final Setup and Verification

```bash
# Open Neovim again
nvim

# Run these commands to verify everything is working:
:checkhealth        # Check for any issues
:Mason              # Opens Mason UI - verify LSPs are installed
:PackerStatus       # Check all plugins are loaded
```

### Step 11: Wait for Automatic LSP Installation

When you open a file for the first time (e.g., `.js`, `.ts`, `.go`, `.rs`), Mason will automatically install the required language servers. This happens in the background and may take a minute.

## Post-Installation Verification Checklist

Run through this checklist to ensure everything is working:

1. **Plugins Loaded**: Run `:PackerStatus` - all 25 plugins should show as loaded
2. **LSPs Working**: Open a `.js` file and type - you should see completions
3. **Telescope Working**: Press `<leader>pf` (Space + p + f) - file finder should open
4. **Treesitter Working**: Syntax highlighting should be visible in code files
5. **Formatters Working**: Press `<leader>f` in a code file - it should format
6. **Git Integration**: Run `:Git` in a git repository - fugitive should work
7. **Color Scheme**: Rose Pine theme should be active with transparent background

## Troubleshooting Common Issues

### Issue: "Packer not found" error
```bash
# Reinstall Packer
rm -rf ~/.local/share/nvim/site/pack/packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Issue: LSP not working
```bash
# In Neovim, run:
:Mason
# Press 'i' to install missing servers manually
```

### Issue: Treesitter errors
```bash
# In Neovim, run:
:TSUpdate
```

### Issue: Telescope not finding files
```bash
# Make sure ripgrep and fd are installed
brew install ripgrep fd
```

### Issue: Icons not displaying correctly
Make sure your terminal is using a Nerd Font (e.g., "Hack Nerd Font")

### Issue: Format on save not working
```bash
# Check formatter is installed for your language
which stylua    # For Lua
which prettier  # For JS/TS
which black     # For Python
```

## Environment Variables (Optional)

Add these to your `~/.zshrc` for better integration:

```bash
# Set Neovim as default editor
export EDITOR='nvim'
export VISUAL='nvim'

# Add local bin to PATH (for pip installations)
export PATH="$HOME/.local/bin:$PATH"
```

## Quick Health Check Command

After installation, create this alias for quick checks:

```bash
echo "alias nvim-check='nvim +checkhealth +qa'" >> ~/.zshrc
source ~/.zshrc

# Run health check
nvim-check
```

## Key Bindings Reference

- **Leader key**: Space
- **Find files**: `<leader>pf`
- **Find in git**: `<C-p>`
- **Format code**: `<leader>f`
- **Open file tree**: `<leader>pv`
- **Claude Code**: `<leader>cc` (open), `<leader>ct` (toggle)

## Final Notes

1. The first time you open Neovim after installation, it may take 1-2 minutes for all Treesitter parsers to compile
2. Mason will automatically install LSPs when you open relevant file types
3. Some features (like tmux-sessionizer) require additional setup outside of Neovim
4. The configuration uses `~/.vim/undodir` for persistent undo - this directory must exist

## Support

If you encounter issues not covered here:
1. Run `:checkhealth` in Neovim for diagnostics
2. Check the original repository: https://github.com/theabecaster/nvim-config
3. Verify all dependencies are installed with `brew list` and `npm list -g`

## Success Indicators

You'll know the setup is complete when:
- No errors on Neovim startup
- Syntax highlighting works in code files
- Auto-completion appears when typing
- `<leader>pf` opens the file finder
- The status line shows file information
- The background is transparent with Rose Pine colors
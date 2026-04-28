#!/bin/bash
# Install oh-my-zsh plugins for fish-like autocomplete

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "Installing zsh plugins for fish-like autocomplete..."
echo ""

# Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "📦 Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  echo "✅ zsh-autosuggestions installed"
else
  echo "✅ zsh-autosuggestions already installed"
fi

echo ""

# Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "📦 Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  echo "✅ zsh-syntax-highlighting installed"
else
  echo "✅ zsh-syntax-highlighting already installed"
fi

echo ""
echo "🎉 All plugins installed!"
echo ""
echo "Now run: source ~/.zshrc"
echo ""
echo "Keybindings:"
echo "  • Ctrl+Space or End    → Accept suggestion"
echo "  • Ctrl+Right Arrow     → Accept one word"
echo "  • Type to get suggestions from history"

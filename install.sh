#!/bin/bash

# このスクリプトは Codespaces 起動時に自動で実行される
echo "Setting up gitconfig..."

# dotfiles のあるディレクトリを取得
DOTFILES_DIR=$(dirname "$0")

# ~/.gitconfig がなければ作成（内容は簡単に）
if [ ! -f ~/.gitconfig ]; then
  cat <<EOF > ~/.gitconfig
[user]
    name = yourname
    email = you@example.com

[include]
    path = ~/.gitconfig.aliases
EOF
  echo "~/.gitconfig created."
fi

# ~/.gitconfig.aliases をコピー
cp "$DOTFILES_DIR/.gitconfig.aliases" ~/.gitconfig.aliases
echo "~/.gitconfig.aliases copied."

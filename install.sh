#!/bin/bash

DOTFILES_DIR=$(dirname "$0")

# ユーザー名を GitHub の環境変数から取得
GIT_USER_NAME=$(git config user.name)
GIT_USER_EMAIL=$(git config user.email)

# 環境変数が空なら、GitHub の noreply アドレスを自動生成（Codespaces用）
if [ -z "$GIT_USER_NAME" ]; then
    if [ -n "$CODESPACES" ]; then
        GIT_USER_NAME="$GITHUB_USER"
        GIT_USER_EMAIL="${GITHUB_USER}@users.noreply.github.com"
    else
        # fallback（ローカル実行時など）
        GIT_USER_NAME="YOUR_NAME"
        GIT_USER_EMAIL="YOUR_EMAIL"
    fi
fi

echo "Setting up .gitconfig with:"
echo "  name: $GIT_USER_NAME"
echo "  email: $GIT_USER_EMAIL"

# ~/.gitconfig がなければ作成
if [ ! -f ~/.gitconfig ]; then
  cat <<EOF > ~/.gitconfig
[user]
    name = $GIT_USER_NAME
    email = $GIT_USER_EMAIL

[include]
    path = ~/.gitconfig.aliases
EOF
  echo "~/.gitconfig created."
fi

# ~/.gitconfig.aliases をコピー
cp "$DOTFILES_DIR/.gitconfig.aliases" ~/.gitconfig.aliases
echo "~/.gitconfig.aliases copied."

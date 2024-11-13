#!/usr/bin/env bash

set -e

DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

# Change default shell to bash
if [ "$SHELL" != "/bin/bash" ]; then
    chsh -s /bin/bash
fi

# MacOS
if [ $(uname -s) == "Darwin" ]; then
    # Installing homebrew
    if ! command -v brew > /dev/null; then
        /bin/bash -c \
            "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Installing desktop applications
    apps=(
        appcleaner
        visual-studio-code
        orbstack
        discord
        microsoft-onenote
        microsoft-powerpoint
    )
    brew install --cask --appdir="/Users/$USER/Applications" ${apps[@]}

    cp bash ~/.bash_profile
else
    cat bash >> ~/.bashrc
fi

# Copy dot files
dotfiles=(
    gitconfig
    vimrc
)
for file in ${dotfiles[@]}; do
  cp $DIR/$file ~/.$file
done
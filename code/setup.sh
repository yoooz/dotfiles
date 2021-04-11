#!/usr/bin/env zsh

extensions=$(cat ./extensions)

for extension in $extensions; do
    echo "install $extension ..."
    code --install-extension $extension
done

ln -s settings.json $HOME/Library/Application\ Support/Code/User/

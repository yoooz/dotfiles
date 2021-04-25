#!/usr/bin/env zsh

extensions=$(cat ./extensions)

for extension in $extensions; do
    echo "install $extension ..."
    code --install-extension $extension
done

cp settings.json $HOME/Library/Application\ Support/Code/User/

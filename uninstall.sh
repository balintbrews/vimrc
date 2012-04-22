#!/bin/sh
INSTALLED_TO=~

cd "$INSTALLED_TO"
rm -rf vimrc
echo "~/vimrc folder has been deleted."
rm -rf .vim
echo "~/.vim folder has been deleted."
rm -rf .vimrc
cd
echo "~/.vimrc has been deleted."
echo "If you want to install again, run the following command inside your home folder:"
echo "wget -O - https://raw.github.com/balintk/vimrc/master/install.sh | sh"


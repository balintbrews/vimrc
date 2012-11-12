#!/bin/sh
INSTALLED_TO=${HOME}

rm -rf "$INSTALLED_TO/vimrc"
echo "~/vimrc folder has been deleted."
rm "$INSTALLED_TO/.vim"
echo "~/.vim folder has been deleted."
rm "$INSTALLED_TO/.vimrc"
echo "~/.vimrc has been deleted."
rm "$INSTALLED_TO/.viminfo"
echo "~/.viminfo has been deleted."

echo "If you want to install again, run the following command inside your home folder:"
echo "wget -O - https://raw.github.com/balintk/vimrc/master/install.sh | sh"


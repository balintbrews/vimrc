#!/bin/sh
INSTALL_TO=${HOME}

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

[ -e "$INSTALL_TO/vimrc" ] && die "$INSTALL_TO/vimrc already exists."
[ -e "~/.vim" ] && die "~/.vim already exists."
[ -e "~/.vimrc" ] && die "~/.vimrc already exists."

cd "$INSTALL_TO"
git clone git://github.com/balintk/vimrc.git
cd vimrc/vim/bundle

# Download vim plugin bundles

# Jellybeans color scheme
git clone https://github.com/nanotech/jellybeans.vim.git jellybeans
# Solarized color scheme
git clone https://github.com/altercation/vim-colors-solarized.git solarized
# Tomorrow color scheme
git clone https://github.com/chriskempson/vim-tomorrow-theme.git tomorrow
# Powerline
git clone https://github.com/Lokaltog/vim-powerline.git
# Syntastic
git clone https://github.com/scrooloose/syntastic.git
# Taglist
git clone https://github.com/vim-scripts/taglist.vim.git taglist
# DBGp Remote Debugger Interface
git clone https://github.com/jsoriano/vim-dbgp.git

# Compile command-t for the current platform
cd command-t/ruby/command-t
(ruby extconf.rb && make clean && make) || warn "Ruby compilation failed. Ruby not installed, maybe?"

# Symlink ~/.vim and ~/.vimrc
cd ~
ln -s "$INSTALL_TO/vimrc/vimrc" .vimrc
ln -s "$INSTALL_TO/vimrc/vim" .vim

echo "-------------------------------------------------------------------------------"
echo "Installed and configured .vim, have fun!"
echo "If you want to push code to the balintk/vimrc repository, run this command:"
echo "cd ~/vimrc; git remote set-url origin git@github.com:balintk/vimrc.git"


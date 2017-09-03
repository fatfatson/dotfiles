#!/bin/bash

dir="$( cd "$( dirname "$0" )" && pwd )"
olddir=~/dotfiles_old 
rm -rf $olddir
mkdir -p $olddir

files="bash_profile bashrc inputrc vimrc vim tmux.conf gitconfig hgrc"
cd "$dir"
for file in $files; do
	[ -f ~/.$file ] && mv -f ~/.$file ~/dotfiles_old/
	ln -s $dir/$file ~/.$file
done

echo dotfiles_home="$dir" > ~/.dotfiles_home

rm -rf ~/.profile
cat profile | sed s/\$USER/`whoami`/ > ~/.profile

[ -f ~/.ssh/config ] && mv ~/.ssh/config  ~/dotfiles_old/sshconfig
mkdir -p ~/.ssh/
ln -s $dir/sshconfig ~/.ssh/config

#!/bin/bash
########## Variables

dir="$( cd "$( dirname "$0" )" && pwd )"
olddir=~/dotfiles_old 
rm -rf $olddir
mkdir -p $olddir

files="bash_profile bashrc inputrc vimrc vim tmux.conf tmux-localprg.sh gitconfig gitignore hgrc"    # list of files/folders to symlink in homedir
cd "$dir"
for file in $files; do
	mv -f ~/.$file ~/dotfiles_old/
	ln -s $dir/$file ~/.$file
done

mv ~/.ssh/config  ~/dotfiles_old/sshconfig
ln -s $dir/sshconfig ~/.ssh/config

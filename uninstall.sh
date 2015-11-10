#!/bin/sh
cd ~
[ -d ~/vim  ] && mv -rf ~/vim ~/vim.$$
[ -d ~/.vim ] && mv -rf ~/.vim ~/.vim.$$
[ -d ~/.vimrc ] && mv -rf ~/.vimrc ~/.vimrc_$$

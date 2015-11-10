#!/bin/bash
TMPFILE="./charlie.dat.$$"
GITSOURCE="https://github.com/xuechao8086/cfgvim.git"
VUNDLE="https://github.com/gmarik/vundle.git"

echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
    echo "you are using Ubuntu"
    sudo apt-get install -y vim ctags astyle python-setuptools python-dev git
elif which yum >/dev/null; then
    echo "you are using RHEL/CentOS"
    sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel	
elif which brew > /dev/null; then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
else
    echo "your flatform unknown"
    exit 1
fi

sudo easy_install -ZU autopep8 
if [ -e /usr/bin/ctags ] 
then
    if [ ! -e /usr/local/bin/ctags ]
    then 
        sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
    fi
else
    echo "ctags not found"
    exit 1
fi

cd ~
[ -d ~/vim  ] && mv -rf ~/vim ~/vim.$$
[ -d ~/.vim ] && mv -rf ~/.vim ~/.vim.$$
[ -d ~/.vimrc ] && mv -rf ~/.vimrc ~/.vimrc_$$

cd ~ && git clone ${GITSOURCE} ~/.vim
[ $? -eq 0 ] || (echo "git clone ${GITSOURCE} fail" && exit 1)

cp ~/.vim/.vimrc ~/

cd ~ && git clone ${VUNDLE} ~/.vim/bundle/vundle
[ $? -eq 0 ] || (echo "git clone ${VUNDLE} fail" && exit 1)

cd ~
echo "正在努力为您安装bundle程序" > ${TMPFILE} 
echo "安装完毕将自动退出" >> ${TMPFILE}
echo "请耐心等待" >> ${TMPFILE}

vim ${TMPFILE} -c "BundleInstall" -c "q" -c "q"
if [ $? -eq 0 ]
then
    rm -rf ${TMPFILE}
    echo "安装完成"
else
    echo "BundleInstall fail"
fi

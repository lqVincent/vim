# vim
- ~/.vim/vim目录下的备份
- 结合vimplus使用

# install:
- 先安装vimplus
- 然后：
 ```sh
 cd ~/.vim
 git clone https://github.com/lqVincent/vim
 cd ~/.vim/vim
 mv ~/.vimrc ~/.vim/vim/.vimrc_bak
 ln -s ~/.vim/vim/.vimrc ~/
 ```

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
 mv ~/.ycm_extra_conf.py ~/.vim/vim/.ycm_extra_conf.py_bak
 ln -s ~/.vim/vim/.ycm_extra_conf.py ~/
 //更新插件
 ```

source ~/.vim/vim/normal.vim
source ~/.vim/vim/plug.vim
source ~/.vim/vim/plug_cfg.vim
source ~/.vim/vim/keymap.vim
source ~/.vim/vim/markdown.editor.vim
source ~/.vim/vim/normal.vim
"""""""""""""""""""""""""""使用skywind3000/vim里的quickui配置 begin""""""""""""""""""""""""""
source ~/.vim/vim/quickui/core.vim
source ~/.vim/vim/quickui/preview.vim
source ~/.vim/vim/quickui/style.vim
source ~/.vim/vim/quickui/tags.vim
source ~/.vim/vim/quickui/tools.vim
source ~/.vim/vim/quickui/utils.vim
"""""""""""""""""""""""""""使用skywind3000/vim里的quickui配置 end""""""""""""""""""""""""""

"将F5映射为自动更新cscope——暂未启用，保持默认配置
"nmap <F5> :!cscope -Rbq<CR>:cs reset<CR><CR>

"让vimrc每次修改后立即生效
" autocmd BufWritePost $MYVIMRC source $MYVIMRC 

"add at 2021-08-27:使vim的y,d,x,p能和系统的ctrl-c,ctrl-v结合使用
"set clipboard=unnamed 

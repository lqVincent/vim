" 编辑vimrc相关配置文件
nnoremap <leader>e :edit $MYVIMRC<cr>
nnoremap <leader>vk :edit ~/.vim/vim/keymap.vim<cr>
nnoremap <leader>vi :edit ~/.vim/vim/init.vim<cr>
nnoremap <leader>vp :edit ~/.vim/vim/plug.vim<cr>
nnoremap <leader>vm :edit ~/.vim/vim/markdown.editor.vim <cr>

" 重新加载vimrc文件
nnoremap <leader>s :source $MYVIMRC<cr>

" 查看vimplus的help文件
nnoremap <leader>h :view +let\ &l:modifiable=0 ~/.vimplus/help.md<cr>

" 打开当前光标所在单词的vim帮助文档
nnoremap <leader>H :execute ":help " . expand("<cword>")<cr>

" 安装、更新、删除插件
nnoremap <leader><leader>i :PlugInstall<cr>
nnoremap <leader><leader>ii :PluginInstall<cr>
nnoremap <leader><leader>u :PlugUpdate<cr>
nnoremap <leader><leader>c :PlugClean<cr>

" 分屏窗口移动
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" 按照//对齐
nnoremap <leader>// :Tab /\/\/<cr> 
nnoremap <leader>= :Tab /=<cr> 

" 清空高亮，先停止使用vim-slash插件，这个插件会使光标离开目标词后停止高亮.
nnoremap <leader>x :noh<cr>

" NERDTree
nnoremap <leader><leader>nf :NERDTreeFind<cr> 
nnoremap <silent> <leader>n :NERDTreeToggle<cr>

" tagbar
"nnoremap <silent> <leader>t :TagbarToggle<cr>

" vim-easymotion
map <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)

" LeaderF
nnoremap <leader>ff :LeaderfFile .<cr>
nnoremap <leader>fu :LeaderfFunction!<cr>
nnoremap <leader>fm :LeaderfMru<cr>

" ack
nnoremap <leader>F :Ack!<space>

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" vim-buffer
nnoremap <silent> <c-p> :PreviousBuffer<cr>
nnoremap <silent> <c-n> :NextBuffer<cr>
nnoremap <silent> <leader>d :CloseBuffer<cr>
nnoremap <silent> <leader>D :BufOnly<cr>

" tabular
nnoremap <leader>l :Tab /\|<cr>
nnoremap <leader>= :Tab /=<cr>

" vim-smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" gv
nnoremap <leader>g :GV<cr>
nnoremap <leader>G :GV!<cr>
nnoremap <leader>gg :GV?<cr>

" 把ctrl+s作为保存键
nnoremap <C-S> :w<CR>
vnoremap <C-S> <C-C>:w<CR>
inoremap <C-S> <Esc>:w<CR>

nnoremap <C-D> :q<CR>
vnoremap <C-D> <C-C>:q<CR>
inoremap <C-D> <Esc>:q<CR>

" 调整窗口大小
nnoremap <F9> <c-w>3<<cr>
nnoremap <F10> <c-w>3><cr>
nnoremap <F1> <c-w>3-<cr>
nnoremap <F2> <c-w>3+<cr>

" 打开文件
nnoremap <leader><leader>o :e 

" 复制当前选中到系统剪切板
vmap <leader>y "+y
" 将系统剪切板内容粘贴到vim
nnoremap <leader>p "+p

" vim中打开终端、调整适当大小
nnoremap <leader><leader>t :terminal<cr><c-w><s-j><c-w>:resize 10<cr><c-w>

" YCM
nnoremap <leader>u :YcmCompleter GoToDeclaration<cr>
nnoremap <leader>o :YcmCompleter GoToInclude<cr>
nnoremap <leader>] :YcmCompleter GoToDefinition<cr>
nmap <F5> :YcmDiags<cr>

"""""""""""""""""""""""""""forkd form skywind3000/vim begin""""""""""""""""""""""""""
noremap <c-l> :call quickui#tools#preview_tag('')<cr>
noremap <c-j> :call quickui#preview#scroll(2)<cr>
noremap <c-k> :call quickui#preview#scroll(-2)<cr>
"""""""""""""""""""""""""""forkd form skywind3000/vim end""""""""""""""""""""""""""

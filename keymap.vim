" 使用mac option键作快捷键时，需要：
" 方法一：
" 1.设置iterm2 -> profiles -> keys -> General:两个option key都设置为Esc++
" 2.map时使用<esc>key,例如 nnoremap <esc>s :w<CR>
" 方法二：
" 在option
" key为normal模式下，直接映射option+key对应的特殊符号，如option-s在Mac上是ß，则直接将ß映射到某一功能

" edit vim cfg
nnoremap <leader>e :edit $MYVIMRC<cr>
nnoremap <leader>vk :edit ~/.vim/vim/keymap.vim<cr>
nnoremap <leader>vi :edit ~/.vim/vim/init.vim<cr>
nnoremap <leader>vpi :edit ~/.vim/vim/plug_in.vim<cr>
nnoremap <leader>vpc :edit ~/.vim/vim/plug_cfg.vim<cr>
nnoremap <leader>vm :edit ~/.vim/vim/markdown.vim <cr>

" reload vimrc
nnoremap <leader><leader>s :source $MYVIMRC<cr>

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

" 调整窗口大小
nnoremap <F9> <c-w>3<<cr>
nnoremap <F10> <c-w>3><cr>
nnoremap <F1> <c-w>3-<cr>
nnoremap <F2> <c-w>3+<cr>

" 关闭指定位置的窗口
nnoremap <leader>jd <c-w>j:CloseBuffer<cr>

" d\c\v\y时，对整个单词生效
nnoremap dw diw
nnoremap cw ciw
nnoremap vw viw
nnoremap yw yiw

" 按照//对齐
nnoremap <leader>// :Tab /\/\/<cr> 
nnoremap <leader>= :Tab /=<cr> 

" 清空高亮，禁用vim-slash插件，这个插件会使光标离开目标词后停止高亮.
nnoremap <silent><leader>x :noh<cr> :call ClearAllHi()<cr>

" NERDTree
nnoremap <leader>nf :NERDTreeFind<cr> 
nnoremap <leader>nn :NERDTreeToggle<cr>

" tagbar
"nnoremap <silent> <leader>t :TagbarToggle<cr>

" vim-easymotion
map <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)

" LeaderF
nnoremap <leader>ff :LeaderfFile<cr>
nnoremap <leader>fu :LeaderfFunction<cr>
nnoremap <leader>fm :LeaderfMru<cr>

" ack
nnoremap <leader>aa :Ack!<space>
" 搜索当前单词
"nnoremap <leader>aw "0yiw :Ack! <c-r>"

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
"noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
"noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

noremap <silent> <c-u> 6k<CR>
noremap <silent> <c-d> 6j<CR>
noremap <c-e> 6<c-e>
noremap <c-y> 6<c-y>

" gv
nnoremap <leader>g :GV<cr>
nnoremap <leader>G :GV!<cr>
nnoremap <leader>gg :GV?<cr>

" 把ctrl+s作为保存键
nnoremap <C-S> :w<CR>
vnoremap <C-S> <C-C>:w<CR>
inoremap <C-S> <Esc>:w<CR>


nnoremap <leader>s :w<CR>
vnoremap <leader>s <C-C>:w<CR>
inoremap <leader>s <Esc>:w<CR>

nnoremap <leader><leader>d :q<CR>
vnoremap <leader><leader>d <C-C>:q<CR>
inoremap <leader><leader>d <Esc>:q<CR>

nnoremap <c-d> :q<CR>
vnoremap <c-d> <C-C>:q<CR>
inoremap <c-d> <Esc>:q<CR>

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

" LSP
nnoremap gd :LspDefinition<cr>
nnoremap gp :LspPeekDefinition<cr>
nnoremap gs :LspWorkspaceSymbol<cr>
nnoremap gr :LspReferences<cr>
nnoremap gK :LspHover<cr>
nnoremap gj : call lsp#scroll(+5)<cr>
nnoremap gk : call lsp#scroll(-5)<cr>
" a-j
nnoremap ∆ : call lsp#scroll(+5)<cr>
" a-k
nnoremap ˚ : call lsp#scroll(-5)<cr>

" highlighting, thanks for https://github.com/sk1418/myConf/blob/master/common/.vimrc#L729
nnoremap <silent> <leader>0 :call ClearAllHi()<cr>
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

nnoremap <silent> gh *N

" for mac, option-key 
" a-s
nnoremap ß :w<cr>
vnoremap ß <C-C>:w<CR>
inoremap ß <Esc>:w<CR>


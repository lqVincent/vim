
"iamcco/markdown-preview.nvim
""""""""""""""""""""Config""""""""""""""""""""
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']

""""""""""""""""""""Mappings""""""""""""""""""""
"autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
"autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
"autocmd Filetype markdown inoremap ,b ****<++><Esc>F*hi
"autocmd Filetype markdown vnoremap ,b di****<Esc>F*hp<Esc>lll
"autocmd Filetype markdown inoremap ,s ~~~~<++><Esc>F~hi
"autocmd Filetype markdown inoremap ,i **<++><Esc>F*i
"autocmd Filetype markdown vnoremap ,i di**<Esc>hpll
"autocmd Filetype markdown inoremap ,,d ``<++><Esc>F`i
"autocmd Filetype markdown vnoremap ,,d di``<Esc>hpll
"autocmd Filetype markdown inoremap ,c ```<Enter>```<Enter><++><Esc>kkA
"autocmd Filetype markdown inoremap ,h ====<Space><++><Esc>F=hi
"autocmd Filetype markdown inoremap ,p ![](<++>)<++><Esc>F[a
"autocmd Filetype markdown inoremap ,a [](<++>)<++><Esc>F[a
"autocmd Filetype markdown inoremap ,l --------<Enter>
"autocmd FileType markdown vnoremap ,q <C-V>0<S-I>> <Esc>
"autocmd Filetype markdown inoremap ,u <u></u><++><Esc>F/hi
"autocmd Filetype markdown vnoremap ,u di<u></u><++><Esc>F/hhp<Esc>/<++><CR>:nohlsearch<CR>c4l<Esc>
autocmd Filetype markdown inoremap ,1 #<Space>
autocmd Filetype markdown nnoremap ,1 i#<Space>
autocmd Filetype markdown inoremap ,2 ##<Space>
autocmd Filetype markdown nnoremap ,2 i##<Space>
autocmd Filetype markdown inoremap ,3 ###<Space>
autocmd Filetype markdown nnoremap ,3 i###<Space>
autocmd Filetype markdown inoremap ,4 ####<Space>
autocmd Filetype markdown nnoremap ,4 i####<Space>
autocmd Filetype markdown inoremap <esc>f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap <esc>b ****<++><Esc>F*hi
autocmd Filetype markdown vnoremap <esc>b di****<Esc>F*hp<Esc>lll
autocmd Filetype markdown inoremap <esc>s ~~~~<++><Esc>F~hi
autocmd Filetype markdown inoremap <esc>i **<++><Esc>F*i
autocmd Filetype markdown vnoremap <esc>i di**<Esc>hpll
autocmd Filetype markdown inoremap <esc>d ``<++><Esc>F`i
autocmd Filetype markdown vnoremap <esc>d di``<Esc>hpll
autocmd Filetype markdown inoremap <esc>c ```<Enter>```<Enter><++><Esc>kkA
autocmd FileType markdown vnoremap <esc>q <C-V>0<S-I>> <Esc>
autocmd Filetype markdown inoremap <esc>u <u></u><++><Esc>F/hi
autocmd Filetype markdown vnoremap <esc>u di<u></u><++><Esc>F/hhp<Esc>/<++><CR>:nohlsearch<CR>c4l<Esc>

"markdown插入图片的插件'ferrine/md-img-paste.vim'相关配置
let g:mdip_imgdir = './pic'
"设置插入截图时的快捷键
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

"for vim-table-mode
"用于兼容markdown
let g:table_mode_corner='|'
"删除行
nnoremap <leader>tdd g:table_mode_delete_row_map 
"删除列
nnoremap <leader>tdc g:table_mode_delete_column_map 
"在光标后插入一列
nnoremap <leader>tic g:table_mode_insert_column_after_map 
"在光标前插入一列
"nnoremap <leader>tic g:table_mode_insert_column_before_map 

"启用斜体、粗体等
let g:markdown_enable_conceal = 1

let s:border_styles = {}

let s:border_styles[1] = quickui#core#border_extract('+-+|-|+-+++')
let s:border_styles[2] = quickui#core#border_extract('┌─┐│─│└─┘├┤')
let s:border_styles[3] = quickui#core#border_extract('╔═╗║─║╚═╝╟╢')
let s:border_styles[4] = quickui#core#border_extract('/-\|-|\-/++')

let s:border_ascii = quickui#core#border_extract('+-+|-|+-+++')
"----------------------------------------------------------------------
" global variables
"----------------------------------------------------------------------
let g:quickui#core#has_nvim = has('nvim')
let g:quickui#core#has_popup = exists('*popup_create') && v:version >= 800
let g:quickui#core#has_floating = has('nvim-0.4')


"----------------------------------------------------------------------
" internal variables
"----------------------------------------------------------------------
let s:windows = has('win32') || has('win16') || has('win64') || has('win95')
let g:quickui#style#border = get(g:, 'quickui#style#border', 1)
let g:quickui#style#tip_head = '[tip]'
let g:quickui#style#preview_w = 85
let g:quickui#style#preview_h = 10
let g:quickui#style#preview_number = 1
let g:quickui#style#preview_bordercolor = ''

"----------------------------------------------------------------------
" private object
"----------------------------------------------------------------------
let s:private = {'winid': -1, 'background': -1, 'state':0}

let s:keymaps = '123456789abcdefimnopqrstuvwxyz'

let s:previous_cursor = {}


""----------------------------------------------------------------------
"" build map
""----------------------------------------------------------------------
"let s:maps = {}
"let s:maps["\<ESC>"] = 'ESC'
"let s:maps["\<CR>"] = 'ENTER'
"let s:maps["\<SPACE>"] = 'ENTER'
"let s:maps["\<UP>"] = 'UP'
"let s:maps["\<DOWN>"] = 'DOWN'
"let s:maps["\<LEFT>"] = 'LEFT'
"let s:maps["\<RIGHT>"] = 'RIGHT'
"let s:maps["\<HOME>"] = 'HOME'
"let s:maps["\<END>"] = 'END'
"let s:maps["\<c-j>"] = 'DOWN'
"let s:maps["\<c-k>"] = 'UP'
"let s:maps["\<c-h>"] = 'LEFT'
"let s:maps["\<c-l>"] = 'RIGHT'
"let s:maps["\<c-n>"] = 'NEXT'
"let s:maps["\<c-p>"] = 'PREV'
"let s:maps["\<c-b>"] = 'PAGEUP'
"let s:maps["\<c-f>"] = 'PAGEDOWN'
"let s:maps["\<c-u>"] = 'HALFUP'
"let s:maps["\<c-d>"] = 'HALFDOWN'
"let s:maps["\<PageUp>"] = 'PAGEUP'
"let s:maps["\<PageDown>"] = 'PAGEDOWN'
"let s:maps["\<c-g>"] = 'NOHL'
"let s:maps['j'] = 'DOWN'
"let s:maps['k'] = 'UP'
"let s:maps['h'] = 'LEFT'
"let s:maps['l'] = 'RIGHT'
"let s:maps['J'] = 'HALFDOWN'
"let s:maps['K'] = 'HALFUP'
"let s:maps['H'] = 'PAGEUP'
"let s:maps['L'] = 'PAGEDOWN'
"let s:maps["g"] = 'TOP'
"let s:maps["G"] = 'BOTTOM'
"let s:maps['q'] = 'ESC'
"let s:maps['n'] = 'NEXT'
"let s:maps['N'] = 'PREV'
"----------------------------------------------------------------------
" preview tag
"----------------------------------------------------------------------
function! quickui#tools#preview_tag(tagname)
	let tagname = (a:tagname == '')? expand('<cword>') : a:tagname
	if tagname == ''
		call quickui#utils#errmsg('Error: empty tagname')
		return 0
	endif
	let obj = quickui#core#object(0)
	let reuse = 0
	if has_key(obj, 'ptag')
		let ptag = obj.ptag
		if get(ptag, 'tagname', '') == tagname
			let reuse = 1
		endif
	endif
	if reuse == 0
		let obj.ptag = {}
		let ptag = obj.ptag
		let ptag.taglist = quickui#tags#tagfind(tagname)
		let ptag.tagname = tagname
		let ptag.index = 0
	else
		let ptag = obj.ptag
		let ptag.index += 1
		if ptag.index >= len(ptag.taglist)
			let ptag.index = 0
		endif
	endif
	if len(ptag.taglist) == 0
		call quickui#utils#errmsg('E257: preview: tag not find "' . tagname . '"')
		return 1
	endif
	if ptag.index >= len(ptag.taglist) || ptag.index < 0
		let ptag.index = 0
	endif
	let taginfo = ptag.taglist[ptag.index]
	let filename = taginfo.filename
	if !filereadable(filename)
		call quickui#utils#errmsg('E484: Can not open file '.filename)
		return 2
	endif
	if !has_key(taginfo, 'line')
		call quickui#utils#errmsg('Error: no "line" information in your tags, regenerate with -n')
		return 3
	endif
	let text = '('.(ptag.index + 1).'/'.len(ptag.taglist).')'
	let opts = {'cursor':taginfo.line, 'title':text}
	call quickui#preview#open(filename, opts)
	let text = taginfo.name
	let text.= ' ('.(ptag.index + 1).'/'.len(ptag.taglist).') '
	let text.= filename
	if has_key(taginfo, 'line')
		let text .= ':'.taginfo.line
	endif
	let display = has('gui_running')? 0 : 1
	let display = get(g:, 'quickui_preview_tag_msg', display)
	if display != 0
		call quickui#utils#print(text, 1)
	endif
	return 0
endfunc


"----------------------------------------------------------------------
" display a error msg
"----------------------------------------------------------------------
function! quickui#utils#errmsg(what)
	redraw
	echohl ErrorMsg
	echom a:what
	echohl None
endfunc


"----------------------------------------------------------------------
" buffer instance
"----------------------------------------------------------------------
function! quickui#core#object(bid)
	let name = '__quickui__'
	let bid = (a:bid > 0)? a:bid : (bufnr())
	if bufexists(bid) == 0
		return v:null
	endif
	let obj = getbufvar(bid, name)
	if type(obj) != v:t_dict
		call setbufvar(bid, name, {})
		let obj = getbufvar(bid, name)
	endif
	return obj
endfunc

"----------------------------------------------------------------------
" easy tagname
"----------------------------------------------------------------------
function! quickui#tags#tagfind(tagname)
	let pattern = escape(a:tagname, '[\*~^')
	let result = quickui#tags#taglist("^". pattern . "$")
	if type(result) == 0 || (type(result) == 3 && result == [])
		if pattern !~ '^\(catch\|if\|for\|while\|switch\)$'
			let result = quickui#tags#taglist('::'. pattern .'$')
		endif
	endif
	if type(result) == 0 || (type(result) == 3 && result == [])
		return []
	endif
	let final = []
	let check = {}
	for item in result
		if item.baditem != 0
			continue
		endif
		" remove duplicated tags
		let signature = get(item, 'name', '') . ':'
		let signature .= get(item, 'cmd', '') . ':'
		let signature .= get(item, 'kind', '') . ':'
		let signature .= get(item, 'line', '') . ':'
		let signature .= get(item, 'filename', '')
		if !has_key(check, signature)
			let final += [item]
			let check[signature] = 1
		endif
	endfor
	return final
endfunc



"----------------------------------------------------------------------
" preview file
"----------------------------------------------------------------------
function! quickui#preview#open(content, opts)
	call quickui#preview#close()
	if type(a:content) == v:t_string && filereadable(a:content) == 0
		call quickui#utils#errmsg('E484: Cannot open file ' . a:content)
		return -1
	endif
	let opts = {}
	let opts.w = get(g:, 'quickui_preview_w', g:quickui#style#preview_w)
	let opts.h = get(g:, 'quickui_preview_h', g:quickui#style#preview_h)
	let opts.number = get(a:opts, 'number', g:quickui#style#preview_number)
	let opts.cursor = get(a:opts, 'cursor', -1)
	let title = has_key(a:opts, 'title')? (' ' .. a:opts.title) : ''
	if type(a:content) == v:t_string
		let name = fnamemodify(a:content, ':p:t')
		let opts.title = 'Preview: ' . name . title
	else
		let opts.title = 'Preview' .. ((title == '')? '' : (':' .. title))
	endif
	if g:quickui#style#preview_bordercolor != ''
		let opts.bordercolor = g:quickui#style#preview_bordercolor
	endif
	let opts.persist = get(a:opts, 'persist', 0)
	let opts.focusable = get(g:, 'quickui_preview_focusable', 1)
	if has_key(a:opts, 'syntax')
		let opts.syntax = a:opts.syntax
	endif
	let hr = quickui#preview#display(a:content, opts)
	exec "nnoremap <silent><ESC> :call <SID>press_esc()<cr>"
	return hr
endfunc



"----------------------------------------------------------------------
" safe print
"----------------------------------------------------------------------
function! quickui#utils#print(content, highlight, ...)
	let saveshow = &showmode
	set noshowmode
    let wincols = &columns
    let statusline = (&laststatus==1 && winnr('$')>1) || (&laststatus==2)
    let reqspaces_lastline = (statusline || !&ruler) ? 12 : 29
    let width = len(a:content)
    let limit = wincols - reqspaces_lastline
	let l:content = a:content
	if width + 1 > limit
		let l:content = strpart(l:content, 0, limit - 1)
		let width = len(l:content)
	endif
	" prevent scrolling caused by multiple echo
	let needredraw = (a:0 >= 1)? a:1 : 1
	if needredraw != 0
		redraw 
	endif
	if a:highlight != 0
		echohl Type
		echo l:content
		echohl NONE
	else
		echo l:content
	endif
	if saveshow != 0
		set showmode
	endif
endfunc



"----------------------------------------------------------------------
" wrapping of vim's taglist()
"----------------------------------------------------------------------
function! quickui#tags#taglist(pattern)
    let ftags = []
    try
        let ftags = taglist(a:pattern)
    catch /^Vim\%((\a\+)\)\=:E/
        " if error occured, reset tagbsearch option and try again.
        let bak = &tagbsearch
        set notagbsearch
        let ftags = taglist(a:pattern)
        let &tagbsearch = bak
    endtry
	" take care ctags windows filename bug
	let win = has('win32') || has('win64') || has('win95') || has('win16')
	for item in ftags
		let name = get(item, 'filename', '')
		let item.baditem = 0
		if win != 0
			if stridx(name, '\\') >= 0
				let part = split(name, '\\', 1)
				let elem = []
				for n in part
					if n != ''
						let elem += [n]
					endif
				endfor
				let name = join(elem, '\')
				let item.filename = name
				if has_key(item, 'line') == 0
					if has_key(item, 'signature') == 0
						let kind = get(item, 'kind', '')
						if kind != 'p' && kind != 'f'
							let item.baditem = 1
						endif
					endif
				endif
			end
		endif
	endfor
    return ftags
endfunc


"----------------------------------------------------------------------
" close window
"----------------------------------------------------------------------
function! quickui#preview#close()
	if s:private.winid >= 0
		if has('nvim') == 0
			call popup_close(s:private.winid, 0)
			let s:private.winid = -1
		else
			call nvim_win_close(s:private.winid, 0)
			let s:private.winid = -1
			if s:private.background >= 0
				call nvim_win_close(s:private.background, 0)
				let s:private.background = -1
			endif
		endif
	endif
	let s:private.state = 0
endfunc



"----------------------------------------------------------------------
" create preview window
"----------------------------------------------------------------------
function! quickui#preview#display(content, opts)
	call quickui#preview#close()
	if type(a:content) == v:t_string && filereadable(a:content) == 0
		call quickui#utils#errmsg('E212: Can not open file: '. a:content)
		return -1
	endif
	let s:private.state = 0
	if type(a:content) == v:t_string
		silent let source = bufadd(a:content)
		silent call bufload(source)
	elseif type(a:content) == v:t_list
		let source = a:content
	endif
	let winid = -1
	let title = ''
	if has_key(a:opts, 'title') && (a:opts.title != '')
		let title = ' ' . a:opts.title .' '
	endif
	let w = get(a:opts, 'w', -1)
	let h = get(a:opts, 'h', -1)
	let w = (w < 0)? 50 : w
	let h = (h < 0)? 10 : h
	let border = get(a:opts, 'border', g:quickui#style#border)
	let button = (get(a:opts, 'close', '') == 'button')? 1 : 0
	let color = get(a:opts, 'color', 'QuickPreview')
	let p = s:around_cursor(w + (border? 2 : 0), h + (border? 2 : 0))
	if has('nvim') == 0
		let winid = popup_create(source, {'wrap':1, 'mapping':0, 'hidden':1})
		let opts = {'maxwidth':w, 'maxheight':h, 'minwidth':w, 'minheight':h}
		call popup_move(winid, opts)
		let opts = {'close':'button'}
		let opts.border = border? [1,1,1,1,1,1,1,1,1] : repeat([0], 9)
		let opts.resize = 0
		let opts.highlight = color
		let opts.borderchars = quickui#core#border_vim(border)
		if get(a:opts, 'persist', 0) == 0
			let opts.moved = 'any'
		endif
		let opts.drag = 1
		let opts.line = p[0]
		let opts.col = p[1]
		if title != ''
			let opts.title = title
		endif
		let opts.callback = function('s:popup_exit')
		" let opts.fixed = 'true'
		if has_key(a:opts, 'bordercolor')
			let c = a:opts.bordercolor
			let opts.borderhighlight = [c, c, c, c]	
		endif
		call popup_setoptions(winid, opts)
		let s:private.winid = winid
		call popup_show(winid)
	else
		let opts = {'focusable':0, 'style':'minimal', 'relative':'editor'}
		let opts.width = w
		let opts.height = h
		let opts.row = p[0]
		let opts.col = p[1]
		if has_key(a:opts, 'focusable')
			let opts.focusable = a:opts.focusable
		endif
		if type(source) == v:t_number
			let bid = source
		else
			let bid = quickui#core#scratch_buffer('preview', source)
		endif
		let winid = nvim_open_win(bid, 0, opts)
		let s:private.winid = winid
		let high = 'Normal:'.color.',NonText:'.color.',EndOfBuffer:'.color
		call nvim_win_set_option(winid, 'winhl', high)
		let s:private.background = -1
		if border > 0 && get(g:, 'quickui_nvim_simulate_border', 1) != 0
			let back = quickui#utils#make_border(w, h, border, title, button)
			let nbid = quickui#core#scratch_buffer('previewborder', back)
			let op = {'relative':'editor', 'focusable':0, 'style':'minimal'}
			let op.width = w + 2
			let op.height = h + 2
			let pos = nvim_win_get_config(winid)
			let op.row = pos.row - 1
			let op.col = pos.col - 1
			let bordercolor = get(a:opts, 'bordercolor', color)
			let background = nvim_open_win(nbid, 0, op)
			call nvim_win_set_option(background, 'winhl', 'Normal:'. bordercolor)
			let s:private.background = background
		endif
	endif
	let cmdlist = ['setlocal signcolumn=no norelativenumber']
	if get(a:opts, 'number', 1) == 0
		let cmdlist += ['setlocal nonumber']
	else
		let cmdlist += ['setlocal number']
	endif
	let cursor = get(a:opts, 'cursor', -1)
	if cursor > 0
		let cmdlist += ['exec "normal! gg' . cursor . 'Gzz"']
	endif
	if has_key(a:opts, 'syntax')
		let cmdlist += ['setl ft=' . fnameescape(a:opts.syntax) ]
	endif
	call setbufvar(winbufnr(winid), '__quickui_cursor__', cursor)
	call quickui#core#win_execute(winid, cmdlist)
	call quickui#utils#update_cursor(winid)
	let s:private.state = 1
	if has('nvim')
		if get(a:opts, 'persist', 0) == 0
			autocmd CursorMoved * ++once call s:nvim_autocmd()
		endif
	endif
	return winid
endfunc


function! quickui#core#border_vim(name)
	let border = quickui#core#border_get(a:name)
	return quickui#core#border_convert(border)
endfunc


"----------------------------------------------------------------------
" get a named buffer
"----------------------------------------------------------------------
function! quickui#core#scratch_buffer(name, textlist)
	if !exists('s:buffer_cache')
		let s:buffer_cache = {}
	endif
	if a:name != ''
		let bid = get(s:buffer_cache, a:name, -1)
	else
		let bid = -1
	endif
	if bid < 0
		if g:quickui#core#has_nvim == 0
			let bid = bufadd('')
			call bufload(bid)
			call setbufvar(bid, '&buflisted', 0)
			call setbufvar(bid, '&bufhidden', 'hide')
		else
			let bid = nvim_create_buf(v:false, v:true)
		endif
		if a:name != ''
			let s:buffer_cache[a:name] = bid
		endif
	endif
	call setbufvar(bid, '&modifiable', 1)
	call deletebufline(bid, 1, '$')
	call setbufline(bid, 1, a:textlist)
	call setbufvar(bid, '&modified', 0)
	call setbufvar(bid, 'current_syntax', '')
	call setbufvar(bid, '&filetype', '')
	return bid
endfunc


"----------------------------------------------------------------------
" make border
"----------------------------------------------------------------------
function! quickui#utils#make_border(width, height, border, title, ...)
	let pattern = quickui#core#border_get(a:border)
	let image = []
	let w = a:width
	let h = a:height
	let text = pattern[0] . repeat(pattern[1], w) . pattern[2]
	let image += [text]
	let index = 0
	while index < h
		let text = pattern[3] . repeat(' ', w) . pattern[5]
		let image += [text]
		let index += 1
	endwhile
	let text = pattern[6] . repeat(pattern[7], w) . pattern[8]
	let image += [text]
	let button = (a:0 > 0)? (a:1) : 0
	let align = (a:0 > 1)? (a:2) : ''
	let text = image[0]
	let title = quickui#core#string_fit(a:title, w)
	if align == '' || align == 'l'
		let text = quickui#core#string_compose(text, 1, title)
	elseif align == 'm'
		let left = (w + 2 - len(title)) / 2
		let text = quickui#core#string_compose(text, left, title)
	elseif align == 'r'
		let left = w + 2 - len(title) - 1
		let text = quickui#core#string_compose(text, left, title)
	endif
	if button != 0
		let text = quickui#core#string_compose(text, w + 1, 'X')
	endif
	let image[0] = text
	return image
endfunc


"----------------------------------------------------------------------
" vim/nvim compatible
"----------------------------------------------------------------------
function! quickui#core#win_execute(winid, command)
	if g:quickui#core#has_popup != 0
		if type(a:command) == v:t_string
			keepalt call win_execute(a:winid, a:command)
		elseif type(a:command) == v:t_list
			keepalt call win_execute(a:winid, join(a:command, "\n"))
		endif
	else
		let current = nvim_get_current_win()
		keepalt call nvim_set_current_win(a:winid)
		if type(a:command) == v:t_string
			exec a:command
		elseif type(a:command) == v:t_list
			exec join(a:command, "\n")
		endif
		keepalt call nvim_set_current_win(current)
	endif
endfunc


"----------------------------------------------------------------------
" update cursor line
"----------------------------------------------------------------------
function! quickui#utils#update_cursor(winid)
	let bid = winbufnr(a:winid)
	let row = getbufvar(bid, '__quickui_cursor__', -1)
	let cmd = 'call quickui#utils#show_cursor('. a:winid .', '.row.')'
	call quickui#core#win_execute(a:winid, cmd)
endfunc


function! quickui#core#border_get(name)
	if has_key(s:border_styles, a:name)
		return s:border_styles[a:name]
	endif
	return s:border_ascii
endfunc


function! quickui#core#border_convert(pattern)
	if type(a:pattern) == v:t_string
		let p = quickui#core#border_extract(a:pattern)
	else
		let p = a:pattern
	endif
	let pattern = [ p[1], p[5], p[7], p[3], p[0], p[2], p[8], p[6] ]
	return pattern
endfunc


"----------------------------------------------------------------------
" compose two string
"----------------------------------------------------------------------
function! quickui#core#string_compose(target, pos, source)
	if a:source == ''
		return a:target
	endif
	let pos = a:pos
	let source = a:source
	if pos < 0
		let source = strcharpart(a:source, -pos)
		let pos = 0
	endif
	let target = strcharpart(a:target, 0, pos)
	if strchars(target) < pos
		let target .= repeat(' ', pos - strchars(target))
	endif
	let target .= source
	let target .= strcharpart(a:target, pos + strchars(source))
	return target
endfunc


"----------------------------------------------------------------------
" patterns
"----------------------------------------------------------------------
function! quickui#core#border_extract(pattern)
	let parts = ['', '', '', '', '', '', '', '', '', '', '']
	for idx in range(11)
		let parts[idx] = strcharpart(a:pattern, idx, 1)
	endfor
	return parts
endfunc

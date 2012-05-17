"Miscellaneous {{{
	filetype plugin indent on
	set confirm
	set loadplugins
	set nocompatible
	set incsearch
	set ignorecase
	set smartcase
	set backspace=2
	set fileencodings=ucs-bom,utf-8,default,latin1
	set helplang=en
	set history=50
	set modeline
	set nofoldenable
	set suffixes=.bak,~,.o,.info,.swp,.obj,.info,.aux,.log,.dvi,.bbl,.out,.o,.lo
	set viminfo='20,\"500
"}}}

"Indenting and Formatting {{{
	set autoindent
	set smartindent
	set cindent
	let b:FiletypeForFormatting = 0
	autocmd BufNewFile,BufRead *.cpp let b:FiletypeForFormatting = 'C'
	autocmd BufNewFile,BufRead *.hpp let b:FiletypeForFormatting = 'C'
	autocmd BufNewFile,BufRead *.cc let b:FiletypeForFormatting = 'C'
	autocmd BufNewFile,BufRead *.h let b:FiletypeForFormatting = 'C'
	autocmd BufNewFile,BufRead *.c let b:FiletypeForFormatting = 'C'

	function! PerfectFormat()
		if (b:FiletypeForFormatting == 'C')
			set formatprg=indent\ -npsl\ -npcs
			normal gggqG
			set formatprg=uncrustify\ -c\ ~/.config/uncrustify/cpp.cfg\ -l\ CPP\ --no-backup\ 2>/dev/null
			normal gggqG
			set formatprg=astyle\ --mode=c\ --style=horstmann\ --add-one-line-brackets\ --pad-header\ --align-pointer=type\ --align-reference=type
			normal gggqG
			normal gg
		endif
	endfunction

"}}}

"Display settings {{{
	set shortmess+=I
	set title
	set background=dark
	syntax enable
	set laststatus=2
	set hlsearch
	set wildmenu
	set wildmode=list:longest,full
	set ttyfast
	set ruler
	set number
	set relativenumber
	set showmode
	set showcmd
	set fdm=indent
"}}}

"Mappings {{{
	map Y y$
	nnoremap <C-L> :nohlsearch<CR><C-L>
	nnoremap <silent> <Space> :call SetWindowMode()<CR>
	autocmd TermResponse * map <silent> <special> <Esc> :call UnsetWindowMode()<CR>
	nnoremap <silent> <leader> :call PerfectFormat()<CR>
	"{{{ Movement
		noremap H 0
		noremap J <C-D>z.
		noremap K <C-U>z.
		noremap L $
		noremap <C-H> H
		noremap <C-L> L
	"}}}
	noremap <C-J> J "J no longer joins lines together.
	noremap gK K "K no longer opens a manpage for the word under the cursor.
"}}}

"Window Management {{{
	let g:WinModeSet = 0
	"autocmd VimResized * call WindowModeStatus()

	function! WinMove(key) 
	  let t:curwin = winnr()
	  exec "wincmd ".a:key
	  if (t:curwin == winnr()) "we havent moved
	    if (match(a:key,'[jk]')) "were we going up/down
	      wincmd v
	    else 
	      wincmd s
	    endif
	    exec "wincmd ".a:key
	  endif
	endfunction

	function! WindowModeStatus()
		if (g:WinModeSet == 1)
			echo "-- WINDOW --"
		else
			echo ""
		endif
	endfunction

	function! SetWindowMode()
		if (g:WinModeSet == 0)
			let g:WinModeSet = 1
			nnoremap <silent> h :call WinMove('h')<CR>
			nnoremap <silent> j :call WinMove('j')<CR>
			nnoremap <silent> k :call WinMove('k')<CR>
			nnoremap <silent> l :call WinMove('l')<CR>
			nnoremap <silent> d :wincmd q<CR>
			nnoremap <silent> r <C-W>r
			nnoremap <silent> H :3wincmd <<CR>
			nnoremap <silent> J :3wincmd -<CR>
			nnoremap <silent> K :3wincmd +<CR>
			nnoremap <silent> L :3wincmd ><CR>
		endif
		call WindowModeStatus()
	endfunction
 
	function! UnsetWindowMode()
		if (g:WinModeSet == 1)
			unmap h
			unmap j
			unmap k
			unmap l
			unmap d
			unmap r
			unmap H
			unmap J
			unmap K
			unmap L
		endif
		let g:WinModeSet = 0
		call WindowModeStatus()
	endfunction

"}}}

"Plugins {{{
	let g:ConqueTerm_TERM = 'vt100'
	let g:snippets_dir = $HOME . "/.vim/snippets"
	"let g:solarized_termtrans = 1
	"let g:solarized_termcolors=256
	colorscheme solarized
"}}}


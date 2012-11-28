"{{{ Miscellaneous
	set mouse=""
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

"{{{ Indenting and Formatting
	set autoindent
	set smartindent
	set cindent

	function PerfectFormat()
		if ((&filetype == "cpp") || (&filetype == "c"))
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

"{{{ Display settings
	set shortmess+=I
	set title
	set guioptions=aegitc
	set guicursor+=a:blinkon0
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
	set listchars=eol:⏎,tab:¶\ ,trail:·,extends:+,precedes:-,conceal:↑,nbsp:_
	set showbreak=↪\ 
"}}}

"{{{ Input Settings and Key Bindings
	set timeoutlen=0
	let s:noremaps = ["H ^","J <C-D>z.","K <C-U>z.","L g_","<C-H> H","<C-L> L","Y y$","<C-J> J","gK K","/ /\\v"]
	let s:nnoremaps = ["<CR> o<Esc>k","<silent> <C-U> :nohlsearch<CR><C-L>","<silent> <Space> :call SetWindowMode()<CR>","<silent> <leader> :call PerfectFormat()<CR>"]
	"Only works in gvim:
	let s:gui_nnoremaps = ["<S-Enter> O<Esc>j","<silent> <C-Enter> :call Execute_RHS_of_Cursor()<CR>","<silent> <C-S-Enter> :call Execute_Current_Line()<CR>"]
	"Only works with appropriate keys (Shift+Enter/Ctrl+Enter/Ctrl+Shift+Enter) when in a customized terminal.
	let s:term_nnoremaps = ["[26$ O<Esc>j","<silent> [26^ :call Execute_RHS_of_Cursor()<CR>","<silent> [26@ :call Execute_Current_Line()<CR>"]
	function Execute_RHS_of_Cursor()
		normal! "zy$
		normal! @z
	endfunction
	function Execute_Current_Line()
		normal! ^"zy$
		normal! @z
	endfunction
	function Set_Default_Map()
		for binding in s:noremaps
			execute "noremap " . binding
		endfor
		for binding in s:nnoremaps
			execute "nnoremap " . binding
		endfor
		if has("gui_running")
			for binding in s:gui_nnoremaps
				execute "nnoremap " . binding
			endfor
		else
			for binding in s:term_nnoremaps
				execute "nnoremap " . binding
			endfor
			"Case sensitive search
			map  /\C
		endif
		autocmd TermResponse * map <silent> <special> <Esc> :call UnsetWindowMode()<CR>
	endfunction
	function Set_Cmd_Win_Map()
		if has("gui_running")
			nunmap <S-Enter>
		else
			nunmap [26$
		endif
		nunmap <CR>
	endfunction
	autocmd VimEnter * call Set_Default_Map()
	autocmd CmdwinEnter * call Set_Cmd_Win_Map()
	autocmd CmdwinLeave * call Set_Default_Map()
"}}}

"{{{ Window Management
	let g:WinModeSet = 0
	"autocmd VimResized * call WindowModeStatus()

	function WinMove(key)
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

	function WindowModeStatus()
		if (g:WinModeSet == 1)
			echo "-- WINDOW --"
		else
			echo ""
		endif
	endfunction

	function SetWindowMode()
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
 
	function UnsetWindowMode()
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
		call Set_Default_Map()
	endfunction
"}}}

"{{{ Settings for Specific Filetypes
function! Insert_Include_Guards()
	let filename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
	let time = localtime()
	let uuid = substitute(matchstr(system("uuidgen"), "[^\n\r]*"), "-", "_", "g")
	execute "normal! ggO#ifndef " . filename . "_" . time  . "_" . uuid
	execute "normal! o#define " . filename . "_" . time . "_" . uuid . " "
	normal! o
	execute "normal! Go#endif /* " . filename . "_" . time . "_" . uuid . " */"
	normal! O
	normal! ggjj
endfunction
function Initialize_New_File()
	if (&filetype == "c_header")
		if (! &readonly)
			call Insert_Include_Guards()
		endif
		set filetype=c
	elseif (&filetype == "cpp_header")
		if (! &readonly)
			call Insert_Include_Guards()
		endif
		set filetype=cpp
	endif
endfunction
autocmd BufNewFile *.h set filetype=c_header
autocmd BufNewFile *.hpp set filetype=cpp_header
autocmd BufNewFile * call Initialize_New_File()
"}}}

"{{{ Plugins
	let g:ConqueTerm_TERM = 'vt100'
	let g:snippets_dir = $HOME . "/.vim/snippets"
	"let g:solarized_termtrans = 1
	"let g:solarized_termcolors=256
	colorscheme solarized
    	au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
    	au BufEnter *.org            call org#SetOrgFileType()
"}}}

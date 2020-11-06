set guioptions=
set gfn=Roboto\ Mono\ Nerd\ Font\ Regular\ 11

set t_Co=256
set background=dark
" colorscheme codedark
colorscheme base16-default-dark
highlight LineNr guibg=NONE
highlight NonText guifg=bg
set cursorline

function! StartUp()
	NERDTree
endfunction

autocmd VimEnter * call StartUp()

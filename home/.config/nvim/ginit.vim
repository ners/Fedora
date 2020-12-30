GuiFont! RobotoMono Nerd Font:h12
call GuiClipboard()

set t_Co=256
set background=dark
colorscheme base16-default-dark
highlight LineNr guibg=NONE
highlight NonText guifg=bg
set cursorline

function! StartUp()
	NERDTree
endfunction

autocmd VimEnter * call StartUp()

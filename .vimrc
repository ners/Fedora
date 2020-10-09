set nocompatible
set number
set ruler
set autoindent smartindent
set incsearch hlsearch
set ignorecase smartcase
set ts=4 sts=4 sw=4 noexpandtab
set splitright splitbelow
set encoding=utf-8
set ambiwidth=single
set list
set listchars=tab:›\ ,trail:~,extends:»,precedes:«,nbsp:_
set cursorline

filetype on
syntax on
filetype plugin on
filetype indent on

set hidden
set nobackup nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=number

colorscheme slate

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-@> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

let g:DevIconsDefaultFolderOpenSymbol='ﱮ'
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol=''
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 0
let g:NERDTreeGitStatusUseNerdFonts = 1

function! StartUp()
	NERDTree
endfunction

autocmd VimEnter * call StartUp()
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

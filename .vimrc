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
" set listchars=tab:›\ ,trail:~,eol:↲,extends:»,precedes:«,nbsp:_
set listchars=tab:›\ ,trail:~,extends:»,precedes:«,nbsp:_

filetype on
syntax on
filetype plugin on
filetype indent on

set hidden
set nobackup nowritebackup
" set cmdheight=2
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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
let g:NERDTreeShowHidden=1

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

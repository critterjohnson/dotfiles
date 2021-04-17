" Critter's .vimrc
" should be edited in the dotfiles repo and moved using `make`, not edited
" directly

" Critter vim shortcuts
" Ctrl + \	show/hide NERDTree
" <F7>		open terminal on right
" Shift + <F7>	open terminal on the bottom
" <F3>		toggle search highlighting

" Useful commands
" :GitGutterToggle - toggles vim-gitgutter, which is disabled by default

" material theme
if (has('termguicolors'))
  set termguicolors
endif
colorscheme material

" NERDTree
nnoremap <C-\> :NERDTreeToggle <CR>
autocmd BufWinEnter * silent NERDTreeMirror " copy this NERDTree when a new window (tab) opens
" open NERDTree only if vim was opened with no arguments or data in stdin
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
let g:NERDTreeShowHidden = 1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif " close NERDTree if it's the last window left

" YouCompleteMe
" clangd
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath('clangd')
" let g:ycm_filetype_blacklist = { 'go': 1 } " let vim-go handle go

" vim-go
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1 " requires a powerline font

" vim-gitgutter
let g:gitgutter_enabled = 0

" a.vim
let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc,reg:/src/include/g'
let g:alternateNoDefaultAlternate = 1

" custom shortcuts
nnoremap <F7> :vert term <CR>
nnoremap <S-F7> :term <CR>
nnoremap <F3> :set hlsearch! <CR>

" misc settings
set number
set mouse=a
filetype plugin indent on
syntax on
set hidden
set backspace=indent,eol,start
set hlsearch
set splitbelow
set splitright
set fillchars+=vert:\ 

augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
augroup END


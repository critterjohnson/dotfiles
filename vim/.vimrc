" Critter's .vimrc
" should be edited in the dotfiles repo and moved using `make`, not edited
" directly

""" Critter vim shortcuts
" Ctrl + \	show/hide NERDTree
" <C-P>		:Files - fuzzy search for files
" <C-G>         :rg - fancy search for file
" <F2>          :YcmCompleter GoToDefinition
" <F3>          toggle word wrap
" <F5>          toggle fold
" <F6>          toggle search highlighting
" <F7>		open new tmux pane DOESN'T DO ANYTHING ANYMORE
" <F8>          toggle 80 character colorcolumn
" <leader>d     :YcmCompleter GetDoc
" <leader>gb    open git blame
" <leader>gg    :GitGutterToggle
" <leader>gd    open git diff
" Ctrl + t      next tab
" Shift + t     previous tab

" kitty integration
" <C-(h|j|k|l)> navigates between splits and kitty windows

" material theme
if (has('termguicolors'))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set t_Co=256
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
nnoremap <leader>d :YcmCompleter GetDoc <CR>
nnoremap <F2> :YcmCompleter GoToDefinition <CR>
" let g:ycm_filetype_blacklist = { 'go': 1 } " let vim-go handle go

" vim-go
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_def_mapping_enabled = 0
" other go
autocmd BufEnter *.go  setlocal tabstop=8 shiftwidth=8 softtabstop=8 textwidth=80 noexpandtab cindent cinoptions=:0,l1,t0,g0,(0,W8 filetype=go

" rust.vim
let g:rustfmt_autosave = 1

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1 " requires a powerline font

" vim-fugitive
nnoremap <leader>gb :Git blame <CR>

" vim-gitgutter
let g:gitgutter_enabled = 0
nnoremap <leader>gg :GitGutterToggle <CR>
nnoremap <leader>gd :Gdiffsplit <CR>

" a.vim
" TODO: make a plugin to use fzf instead of a.vim to switch between files,
" could be configured to arbitrarily swap between files
let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc,reg:/src/include/g' " add a regex pattern to replace src with include
let g:alternateNoDefaultAlternate = 1

" fzf
set rtp+=~/fzf
let g:fzf_layout = {'down' : '~20%'}

" kitty
let g:kitty_navigator_no_mappings = 1
nnoremap <silent> <C-h> :KittyNavigateLeft <CR>
nnoremap <silent> <C-j> :KittyNavigateDown <CR>
nnoremap <silent> <C-k> :KittyNavigateUp <CR>
nnoremap <silent> <C-l> :KittyNavigateRight <CR>
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" markdown stuff
autocmd BufEnter *.md setlocal textwidth=80

" custom vim shortcuts
nnoremap <F3> :set wrap! <CR>
nnoremap <F4> :set relativenumber! <CR>
nnoremap <F6> :set hlsearch! <CR>
nnoremap <F7> :!tmux split-window -h -p 30<CR><CR>
nnoremap <F8> :execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<CR>
nnoremap <C-P> :Files <CR>
nnoremap <C-G> :Rg <CR>
nnoremap <expr> <F5> &foldlevel ? 'zM' :'zR'
nnoremap <silent> <C-t> :tabn <CR>
nnoremap <silent> <S-t> :tabp <CR>
" move by visual line (not wrapped line)
nmap j gj
nmap k gk

" line number stuff
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

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
set expandtab
set autoindent
set smartindent
set shiftwidth=4
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set foldmethod=syntax
set foldlevel=99
set directory=$HOME/.vim/swapfiles//
set incsearch
let &t_ut=''

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
augroup END


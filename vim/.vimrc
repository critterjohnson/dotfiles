" make sure this is being edited in the dotfiles repo

" material theme
if (has('termguicolors'))
  set termguicolors
endif
colorscheme material

" NERDTree
nnoremap <C-\> :NERDTreeToggle<CR>
autocmd VimEnter * NERDTree | wincmd p " open NERDTree when vim runs and move cursor to other window
autocmd BufWinEnter * silent NERDTreeMirror " copy this NERDTree when a new window (tab) opens
" Start NERDTree. If a file is specified, move the cursor to its window. https://github.com/preservim/nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
let g:NERDTreeShowHidden = 1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif " close NERDTree if it's the last window left

" misc
set number

augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
augroup END


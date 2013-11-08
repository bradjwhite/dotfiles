" Use Pathogen
call pathogen#incubate()
call pathogen#helptags()

"==================================================
" Vundle stuff
"==================================================
set nocompatible                    " be iMproved
filetype off                        " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let vundle manage Vundle (required)!
Bundle 'gmarik/vundle'

" My bundles here:
" Repos on GitHub
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'wincent/Command-T'


"==================================================
" Ruby stuff
"==================================================
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins


" Enable a text-opject for ruby blocks
runtime macros/matchit.vim

" Autocmd settings
if has("autocmd")
  " Enables plugin, auto-indent and file type detection

  "Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make       setlocal ts=8 sts=8 sw=8 noet
  autocmd FileType yaml       setlocal ts=2 sts=2 sw=2 et

  " Customisations based on house-style (arbitrary)
  autocmd FileType ruby       setlocal ts=2 sts=2 sw=2 et
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noet

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml

  " Strip trailing whitespace from some filetypes
  autocmd BufWritePre *.py,*.js,*.rb :call <SID>StripTrailingWhitespaces()

endif

" Default tab settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Set tabstop, softabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts  = l:tabstop
    let &l:sw  = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

nmap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Show highlighting groups for current word
nmap <M-p> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Turn of backups
set nobackup

" Set the colorscheme
set background=dark
"colorscheme ir_black
colorscheme darkblue

" Turn on search highlighting
set hlsearch


" Change the way you exit normal mode
:inoremap jk <esc>
:inoremap <esc> <nop>

" Turn off the motion keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Make window navigation easier
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Turn on linenumbers by default
set relativenumber

" Create match group for ExtraWhiteSpace
:highlight ExtraWhitespace ctermbg=gray guibg=gray

" Show trailing whitespace:
:match ExtraWhitespace /\s\+$/

:let mapleader = ","
nmap <leader>l  :set list!<CR>

" Display whitespace with different characters
"▸ = ctrl-v u25b8
"¬ = ctrl-v u00ac
"☠ = ctrl-v u2620

" set listchars=tab:▸\ ,eol:¬

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Custom highlight for search
highlight Search ctermbg=black ctermfg=yellow cterm=underline


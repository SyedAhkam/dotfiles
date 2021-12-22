if &compatible
  set nocompatible               " Be iMproved
endif

" Fix tabs as always
set tabstop=4 softtabstop=4 
set shiftwidth=4
set expandtab
set smartindent

" Executes vimrc's in individual project directories
set exrc

" Enable relative line numbers
set relativenumber
set nu " also show current line number

" Stop highlighting after search is over
set nohlsearch

" Allow buffers to live in background
set hidden

" Disable text wrapping by default
set nowrap

" Deal with backup files
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Enable incremental search
set incsearch

" Start scrolling through the page before cursor reaches the bottom
set scrolloff=8

" Add the sign column
set signcolumn=yes

"dein Scripts-----------------------------

set runtimepath+=/home/syed/.dein/repos/github.com/Shougo/dein.vim

call dein#begin('/home/syed/.dein')

" Let dein manage dein
call dein#add('/home/syed/.dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
call dein#add('nvim-telescope/telescope.nvim') " fuzzy finder
call dein#add('folke/tokyonight.nvim') " colorscheme
call dein#add('kyazdani42/nvim-web-devicons') " spaceline depends on this
call dein#add('glepnir/spaceline.vim') " status line

call dein#end()

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" Set colorscheme !!
let g:tokyonight_style = "night"
colorscheme tokyonight

" Customize statusline
let g:spaceline_seperate_style = 'arrow'
let g:spaceline_colorscheme = 'nord' " tokyonight not supported :( the closest is nord

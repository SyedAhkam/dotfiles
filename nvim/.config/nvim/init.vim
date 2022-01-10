if &compatible
  set nocompatible               " Be iMproved
endif

" Fix tabs as always
set tabstop=4 softtabstop=4 
set shiftwidth=4
set expandtab
set smartindent

" Always prefer using sh even if running in fish
set shell=sh

" Always prefer UTF-8 encoding
set encoding=UTF-8

" Enable termguicolors
set termguicolors

" Enable mouse support
set mouse=a

" Executes vimrc's in individual project directories
set exrc

" Enable relative line numbers
set relativenumber
set nu " also show current line number

" Stop highlighting after search is over
set nohlsearch

" Enable filetype plugin
filetype plugin on

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

" Move through splits using the ctrl key
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR> "key conflict
nnoremap <silent> <c-l> :wincmd l<CR>

"dein Scripts-----------------------------

set runtimepath+=/home/syed/.dein/repos/github.com/Shougo/dein.vim

call dein#begin('/home/syed/.dein')

" Let dein manage dein
call dein#add('/home/syed/.dein/repos/github.com/Shougo/dein.vim')

" Add dein UI
call dein#add('wsdjeg/dein-ui.vim')

" Add or remove your plugins here like this:
call dein#add('folke/tokyonight.nvim') " colorscheme
call dein#add('glepnir/spaceline.vim') " status line
call dein#add('mhinz/vim-startify') " start page
call dein#add('akinsho/bufferline.nvim') " bufferline
call dein#add('norcalli/nvim-colorizer.lua') " colorizer
call dein#add('steelsojka/pears.nvim') " bracket pair completion
call dein#add('akinsho/toggleterm.nvim') " better term
call dein#add('lukas-reineke/headlines.nvim') " better markdown headlines
call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'sh -c "cd app && yarn install"' }) " markdown preview
call dein#add('preservim/nerdcommenter') " commenting plugin

" Telescope specific plugins
call dein#add('nvim-telescope/telescope-fzf-native.nvim')
call dein#add('nvim-lua/plenary.nvim')
call dein#add('nvim-telescope/telescope.nvim')

" File browser specific plugins
call dein#add('kyazdani42/nvim-tree.lua')

" Load icons (loaded after its dependents)
call dein#add('kyazdani42/nvim-web-devicons')

" Treesitter specific plugins
call dein#add('nvim-treesitter/nvim-treesitter')

" LSP specific plugins
call dein#add('neovim/nvim-lspconfig')
call dein#add('ms-jpq/coq_nvim') " autocomplete
call dein#add('ms-jpq/coq.artifacts')

" Language specific plugins
" Rust
call dein#add('simrat39/rust-tools.nvim')

call dein#end()

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#update()
endif

"End dein Scripts-------------------------

" Set colorscheme !!
let g:tokyonight_style = "night"
colorscheme tokyonight

" Customize statusline
let g:spaceline_seperate_style = 'arrow'
let g:spaceline_colorscheme = 'nord' " tokyonight not supported :( the closest is nord

" Customize start page
"let g:startify_custom_header = startify#pad(split(system('figlet -w 100 SyedAhkam'), '\n'))
"let g:startify_custom_header = startify#pad(split(system('cowsay -f tux UwU'), '\n'))

" Neovide specific config
if exists('g:neovide')
    "set guifont=Iosevka\ Nerd\ Font:h8
    "set guifont=MesloLGS\ NF:h9
    "set guifont=Delugia\ Nerd\ Font:h1
    set guifont=Firacode\ Nerd\ Font:h1
endif

" Customize nvim-tree
lua << EOF
require'nvim-tree'.setup {
    diagnostics = { enable = true }
}
EOF

nnoremap <F3> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" Enable/Customize bufferline
lua << EOF
require("bufferline").setup{
    options = {
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_close_icon = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        custom_areas = {
            right = function() return {{text = "Vim <3" , guifg = "#c0caf5"}} end
        }
    }
}
EOF

" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
"nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent><M-k> :BufferLineCycleNext<CR>
nnoremap <silent><M-j> :BufferLineCyclePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>

nnoremap <silent>bq :bdelete<cr>

" Enable Colorizer
lua require'colorizer'.setup()

" Enable Pears
lua require "pears".setup()

" Enable Headlines
lua require("headlines").setup()

" Setup ToggleTerm
lua << EOF
require("toggleterm").setup{
    shell="fish"
}
EOF
nnoremap <leader>t <cmd>:ToggleTerm<CR> 
tnoremap <ESC>t<cmd>:ToggleTerm<CR>

" Setup nerdcommenter
let g:NERDCreateDefaultMappings = 0

map <leader>/ <plug>NERDCommenterToggle<cr>
map <leader>cc <plug>NERDCommenterComment<cr>
map <leader>cs <plug>NERDCommenterSexy<cr>
map <leader>cn <plug>NERDCommenterNested<cr>

" Setup telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').file_browser()<cr>

lua << EOF
local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF

" Setup LSP
lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.rust_analyzer.setup{}
EOF

" Configure Coq
lua << EOF
vim.g.coq_settings = {
    ['auto_start'] = true,
    ['keymap.jump_to_mark'] = '<c-f>'
}
EOF

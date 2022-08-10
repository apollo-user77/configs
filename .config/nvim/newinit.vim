" A advanced text editor like config for nvim
" Its probably trash
call plug#begin('~/.nvim/plugged')
Plug 'vim-airline/vim-airline'			
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'			
Plug 'dkarter/bullets.vim' 		
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'preservim/vim-markdown'
Plug 'mattn/emmet-vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons' 
"Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

let g:CtrlSpaceDefaultMappingKey = "<C-space> "
"set showtabline=0

if has('termguicolors')
    set termguicolors
endif

"vim.opt.list = true
"vim.opt.listchars:append("space:⋅")
"vim.opt.listchars:append("eol:↴")

"require("indent_blankline").setup {
"    show_end_of_line = true,
"    space_char_blankline = ".",
"}

set background=dark
colorscheme deus
let g:airline_theme = 'deus'
let g:airline_powerline_fonts = 1

let g:dashboard_default_executive ='telescope'

let mapleader = " "
map <leader>w :w<CR>
map <leader>q :q<CR>
map <leader>x :x<CR>
map <leader>t :NERDTreeToggle<CR>
map <leader>, :bp<CR>
map <leader>. :bn<CR>
map <leader>bd :bd<CR>
map <leader>hex :%!xxd<CR>
map <leader>et :set expandtab<CR>
map <leader>net :set noexpandtab<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

syntax on
set encoding=utf-8
set clipboard^=unnamed,unnamedplus
set mouse=a
set relativenumber number
set foldcolumn=1
set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set scrolloff=8
set nocompatible
set hidden

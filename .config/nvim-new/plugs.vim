call plug#begin('~/.nvim/plugged')
"Writing
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'preservim/vim-markdown'
Plug 'dkarter/bullets.vim'
Plug 'junegunn/limelight.vim'


"Adding Features
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'nvim-lualine/lualine.nvim'
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'justinmk/vim-sneak'
Plug 'mattn/emmet-vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'


"LSP 
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/nvim-lsp-installer'

"" LSP Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'

"" snippet stuff
"Plug 'saadparwaiz/cmp_luasnip'
"Plug 'L3MON4D3/LuaSnip


"Customizations
Plug 'rafi/awesome-vim-colorschemes'
Plug 'mhinz/vim-startify'
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'ryanoasis/vim-devicons'
Plug 'preservim/vim-colors-pencil'
Plug 'arzg/vim-substrata'
Plug 'sainnhe/sonokai'
call plug#end()

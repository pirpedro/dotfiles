" =========================================
" Neovim plugins (vim-plug)
" =========================================
call plug#begin('~/.config/nvim/plugged')

" Theme (Lua port)
Plug 'Mofiqul/dracula.nvim'

" Core Lua helpers / icons
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'

" File explorer & fuzzy finder
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Git
Plug 'tpope/vim-fugitive'          " still great for :G*
Plug 'lewis6991/gitsigns.nvim'     " signs, hunks, blame

" UI
Plug 'nvim-lualine/lualine.nvim'   " statusline
Plug 'akinsho/bufferline.nvim'     " tabs-as-buffers (optional, needs web-devicons)
Plug 'folke/which-key.nvim'        " keyhint popup
Plug 'lukas-reineke/indent-blankline.nvim'  " indent guides

" Editing QoL (Neovim-native)
Plug 'numToStr/Comment.nvim'       " modern comment toggler
Plug 'kylechui/nvim-surround'      " surround text objects
Plug 'windwp/nvim-autopairs'       " autopairs
Plug 'ggandor/leap.nvim'           " fast motions
Plug 'moll/vim-bbye'               " :Bdelete keep splits
Plug 'tpope/vim-eunuch'            " :Rename, :Move, etc.
Plug 'tpope/vim-abolish'           " :Subvert, coercion
Plug 'airblade/vim-rooter'         " auto-chdir to project root
Plug 'editorconfig/editorconfig-vim'

" LSP + completion (Neovim)
Plug 'neovim/nvim-lspconfig'       " LSP client configs
Plug 'williamboman/mason.nvim'     " LSP/DAP/formatter installer
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'            " completion menu
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'            " snippets engine
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" Syntax & textobjects
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Diagnostics / lists (nice with LSP)
Plug 'folke/trouble.nvim'

" Formatting / tools (config depois)
Plug 'stevearc/conform.nvim'       " formatter runner
Plug 'folke/todo-comments.nvim'    " TODO/FIXME highlights
Plug 'akinsho/toggleterm.nvim'     " built-in terminal manager

" Languages / DevOps extras
Plug 'pearofducks/ansible-vim', { 'for': 'yaml' }
Plug 'hashivim/vim-terraform'
Plug 'ekalinin/Dockerfile.vim'
Plug 'towolf/vim-helm'
Plug 'preservim/vim-markdown', { 'for': 'markdown' }

call plug#end()

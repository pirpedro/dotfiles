"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins intallation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_path = expand('~/.vim')
if has("nvim")
  let s:vim_path = expand('~/.config/nvim')
endif 

call plug#begin(s:vim_path.'/plugged')

Plug 'dracula/vim', {
  \ 'as': 'dracula' }                          " Template scheme for vim.

Plug 'preservim/nerdtree', {
  \ 'on':  'NERDTreeToggle' }                  " The NERD tree allows you to explore your filesystem and to open files and directories.
Plug 'Xuyuanp/nerdtree-git-plugin'             " A plugin of NERDTree showing git status flags.
Plug 'ryanoasis/vim-devicons'                  " Add file icons. It requires an installation of a Nerd Font (https://github.com/ryanoasis/nerd-fonts).
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Add color to devicons.
Plug 'scrooloose/syntastic'                    " Syntastic is a syntax checking plugin for Vim that runs files through external syntax checkers and displays any resulting errors to the user
Plug 'tpope/vim-fugitive'                      " Git wrapper for vim
Plug 'tpope/vim-surround'                      " provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-repeat'                        " Repeat.vim remaps . in a way that plugins can tap into it."  
Plug 'easymotion/vim-easymotion'               " EasyMotion provides a much simpler way to use some motions in vim.
Plug 'ctrlpvim/ctrlp.vim'                      " Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'majutsushi/tagbar'                       " Tagbar is a Vim plugin that provides an easy way to browse the tags of the current file and get an overview of its structure. 
Plug 'preservim/nerdcommenter'                 " Comment functions so powerful—no comment necessary.  
Plug 'airblade/vim-gitgutter'                  " A Vim plugin which shows a git diff in the 'gutter' (sign column).
Plug 'valloric/youcompleteme'                  " YouCompleteMe is a fast, as-you-type, fuzzy-search code completion engine for Vim.
Plug 'pearofducks/ansible-vim'
Plug 'vim-airline/vim-airline'                 " Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/bufexplorer.zip'             " Quickly and easily switch between buffers. This plugin can be opened with <leader+o>
Plug 'junegunn/goyo.vim'                       " Distraction-free writing in Vim.
Plug 'itchyny/lightline.vim'                   " A light and configurable statusline/tabline plugin for Vim
Plug 'editorconfig/editorconfig-vim'           " EditorConfig helps maintain consistent coding styles for multiple developers working on the same project across various editors and IDEs.
Plug 'mg979/vim-visual-multi'                  " ublime Text style multiple selections for Vim, CTRL+N is remapped to CTRL+S (due to YankRing)

" Vim modes
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'                    " This vim bundle adds syntax highlighting, indenting and autocompletion for the dynamic stylesheet language LESS.
Plug 'sophacles/vim-bundle-mako'              " Python syntax
Plug 'preservim/vim-markdown'
Plug 'vim-scripts/nginx.vim'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'Vimjas/vim-python-pep8-indent'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 0

call plug#end()

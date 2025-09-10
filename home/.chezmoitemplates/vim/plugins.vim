"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins intallation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }                          " Template scheme for vim.

" Files / fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'                      " The NERD tree allows you to explore your filesystem and to open files and directories.
Plug 'Xuyuanp/nerdtree-git-plugin'             " A plugin of NERDTree showing git status flags.
Plug 'ryanoasis/vim-devicons'                  " Add file icons. It requires an installation of a Nerd Font (https://github.com/ryanoasis/nerd-fonts).
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Add color to devicons.


" Git / status
Plug 'tpope/vim-fugitive'                      " Git wrapper for vim
Plug 'tpope/vim-rhubarb'                             " :GBrowse for GitHub
Plug 'airblade/vim-gitgutter'                  " A Vim plugin which shows a git diff in the 'gutter' (sign column).

" Editing QoL
Plug 'tpope/vim-surround'                      " provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'                        " Repeat.vim remaps . in a way that plugins can tap into it.
Plug 'mg979/vim-visual-multi'                  " sublime Text style multiple selections for Vim, CTRL+N is remapped to CTRL+S (due to YankRing)
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-eunuch'                              " :Rename, :Delete, etc.
Plug 'tpope/vim-abolish'                             " :Subvert, case coercion
Plug 'moll/vim-bbye'                                 " :Bdelete without closing split
Plug 'airblade/vim-rooter'                           " Auto-chdir to project root
Plug 'tpope/vim-sleuth'                              " Detect indentation


" Linting / LSP / Completion
Plug 'dense-analysis/ale'                            " Async linting & fixers
Plug 'prabirshrestha/vim-lsp'                        " LSP client for Vim 8
Plug 'prabirshrestha/asyncomplete.vim'               " Completion engine
Plug 'prabirshrestha/asyncomplete-lsp.vim'           " LSP source for asyncomplete
Plug 'prabirshrestha/asyncomplete-buffer.vim'


" Code structure / tags
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'                  " Auto-manage ctags
Plug 'rhysd/conflict-marker.vim'                     " Better conflict markers

" EditorConfig
Plug 'editorconfig/editorconfig-vim'           " EditorConfig helps maintain consistent coding styles for multiple developers working on the same project across various editors and IDEs.

" Languages
Plug 'sheerun/vim-polyglot'                          " Broad language support
Plug 'pearofducks/ansible-vim', { 'for': 'yaml' }
Plug 'hashivim/vim-terraform'
Plug 'ekalinin/Dockerfile.vim'
Plug 'towolf/vim-helm'                               " Helm templates & gotpl
Plug 'preservim/vim-markdown', { 'for': 'markdown' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript','typescript'] }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible  " Make Vim more useful
set history=500                      " Sets how many lines of history VIM has to remember
filetype plugin on                   " Enable filetype plugins
filetype indent on
set autoread                         " Set to auto read when a file is changed from the outside
autocmd FocusGained,BufEnter * checktime
let mapleader = ","                  " With a map leader it's possible to do extra key combinations
                                     " like <leader>w saves the current file
nnoremap <leader>w :w!<cr>               " Fast saving
inoremap jk <ESC>                    " map jk to <ESC>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' | edit!

" Replicate :w as :W (range-aware)
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>

" Close current buffer helpers (keep your functions below)
command! -bang Q  :call CloseCurrentBuffer(<bang>0, 0)
command! -bang WQ :call CloseCurrentBuffer(<bang>0, 1)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmenu                   " Turn on the Wild menu
set wildmode=longest:full,full " Command-line completion mode
set ruler                      " Always show current position
set cmdheight=1                " Height of the command bar
set hidden                     " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l
set ignorecase                 " Ignore case when searching
set smartcase                  " When searching try to be smart about cases
set hlsearch                   " Highlight search results
set incsearch                  " Makes search act like search in modern browsers
set lazyredraw                 " Don't redraw while executing macros (good performance config)
set magic                      " For regular expressions turn magic on
set showmatch                  " Show matching brackets when text indicator is over them
set noerrorbells novisualbell  " No annoying sound on errors
set foldcolumn=1               " Add a bit extra margin to the
set colorcolumn=80             " Add a visual red ruler
set modeline modelines=2 secure" Respect modeline in files
set gdefault                   " Add the g flag to search/replace by default
set number relativenumber      " Enable line numbers
set signcolumn=yes             " Always show the signcolumn to avoid shifting text each time
set cursorline                 " Highlight the current line
set showcmd                    " Show the (partial) command as it’s being typed
set scrolloff=3                " Start scrolling three lines before the horizontal window border
set splitbelow splitright      " New horizontal/vertical splits will be below the current window
set mouse=a                    " Enable mouse support in all modes

" Ignore compiled/junk files in completion/wildmenu
set wildignore=*.o,*~,*.pyc
if has('win32') || has('win64')
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/node_modules/*,*/__pycache__/*
endif

" Better defaults
set linebreak               " Wrap at word boundaries
set list!                   " Visualize tabs/trails when needed (toggle off with :set nolist)
set formatoptions+=jcroql   " Smarter formatting (keep comments, respect lists, etc.)
set formatoptions-=t        " Do not hard-wrap while typing
set updatetime=250


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
" Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

try
    colorscheme dracula
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guitablabel=%M\ %t
    set guifont=Fira\ Code:h14
endif

set encoding=utf-8          " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac       " Use Unix as the standard file type

" Change colors on vimdiff
highlight DiffAdd    cterm=NONE ctermbg=LightGreen  gui=none guifg=bg guibg=#90D090
highlight DiffDelete cterm=NONE ctermbg=LightRed    gui=none guifg=bg guibg=#EC7C7C
highlight DiffChange cterm=NONE ctermbg=LightBlue   gui=none guifg=bg guibg=#6090C0
highlight DiffText   cterm=NONE ctermbg=Cyan        gui=none guifg=bg guibg=#8FBFE7


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup nowritebackup noswapfile" Turn backup off, since most stuff is in SVN, git etc. anyway...
" Persistent undo (better safety)
if has('persistent_undo')
  set undofile
  if isdirectory(expand('~/.vim/undo')) == 0
    silent! call mkdir(expand('~/.vim/undo'), 'p', 0700)
  endif
  set undodir=~/.vim/undo
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab smarttab                    " Use spaces instead of tabs and Be smart when using tabs
set shiftwidth=2 tabstop=2 softtabstop=2  " 1 tab == 2 spaces
set autoindent smartindent
set wrap
set linebreak
set textwidth=0 " do not hard-wrap automatically


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

" Search for visual selection using ripgrep+fzf (fallback to plain / if Rg is missing)
vnoremap <silent> * :<C-u>call VisualSelection('search', '')<CR>
vnoremap <silent> # :<C-u>call VisualSelection('back',  '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <space> /    " Map <Space> to / (search)
map <C-space> ?  " Map Ctrl-<Space> to ? (backwards search)

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Arrow keys discouraged
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Buffer management
map <leader>bd :Bclose<cr>:tabclose<cr>gT  " Close the current buffer
map <leader>ba :bufdo bd<cr>               " Close all the buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
autocmd TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<CR>/

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute 'normal! g`"' | endif

" Next/prev buffer with Ctrl-Left/Right
nnoremap <silent> <C-Right> :call NextBuf()<CR>
nnoremap <silent> <C-Left> :call PrevBuf()<CR>

" Move lines with Alt+j/k
nnoremap <A-j> ddp
nnoremap <A-k> ddkP
vnoremap <A-j> :m'>+<CR>`<my`>mzgv`yo`z
vnoremap <A-k> :m'<-2<CR>`>my`<mzgv`yo`z



" Switch between different windows by their direction
nnoremap <silent> <A-Down> <C-w>j| "switching to below window
nnoremap <silent> <A-Up> <C-w>k| "switching to above window
nnoremap <silent> <A-Right> <C-w>l| "switching to right window
nnoremap <silent> <A-Left> <C-w>h| "switching to left window



""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
set laststatus=2   " Always show the status line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
nnoremap 0 ^

" Strip trailing whitespace on save (common filetypes)
function! CleanExtraSpaces()
  let save_cursor = getpos('.')
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.ts,*.tsx,*.json,*.yaml,*.yml,*.tf call CleanExtraSpaces()

" Auto-read when file changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
      \ if mode() !~# '\v(c|r.?|!|t)' && getcmdwintype() ==# '' | checktime | endif
autocmd FileChangedShellPost * echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ss :setlocal spell!<cr>  " Pressing ,ss will toggle and untoggle spell checking
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm " Remove the Windows ^M - when the encodings gets messed up
nnoremap <leader>q :e ~/buffer<cr> " Quickly open a buffer for scribble
nnoremap <leader>x :e ~/buffer.md<cr> " Quickly open a markdown buffer for scribble

" Clipboard mappings (note: <C-v> is 'insert literal' in Vim; keep if suits your workflow)
vnoremap <C-c> "+y
vnoremap <C-v> "+p
vnoremap . :norm.<CR> " Repeat dot in visual mode

" Very magic search by default
nnoremap / /\v
vnoremap / /\v

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
  return &paste ? 'PASTE MODE  ' : ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:cur = bufnr('%')
  let l:alt = bufnr('#')
  if buflisted(l:alt)
    buffer #
  else
    bnext
  endif
  if bufnr('%') == l:cur
    enew
  endif
  if buflisted(l:cur)
    execute 'bdelete!' l:cur
  endif
endfunction

function! CmdLine(str)
  call feedkeys(':' . a:str)
endfunction

" VisualSelection: use fzf's :Rg if available; fallback to plain search
function! VisualSelection(direction, extra_filter) range
  let l:saved = @"
  normal! gv"xy
  let l:pattern = escape(@x, '\/.*$^~[]')
  let l:pattern = substitute(l:pattern, '\n\+$', '', '')

  if a:direction ==# 'search'
    if exists(':Rg')
      execute 'Rg ' . shellescape(l:pattern)
    else
      let @/ = l:pattern
      normal! n
    endif
  elseif a:direction ==# 'back'
    let @/ = l:pattern
    normal! N
  elseif a:direction ==# 'replace'
    call CmdLine('%s/' . l:pattern . '/')
  endif

  let @" = l:saved
endfunction

function! GetCwd()
  if exists('g:NERDTree') && g:NERDTree.ForCurrentTab() isnot v:null
    return g:NERDTree.ForCurrentTab().getRoot().path.str()
  endif
  return getcwd()
endfunction

function! PrintError(msg, prompt)
  echohl ErrorMsg | echom a:msg | echohl None
  if a:prompt | echohl Question | echom '' | echohl None | endif
endfunction

function! CloseCurrentBuffer(force, save)
  let curbuf = bufnr('%')
  let lastbuf = bufnr('$')
  let mvbuf = curbuf == lastbuf ? 'bp' : 'bn'
  if &modified
    if a:save
      if &readonly && !a:force
        call PrintError("'readonly' option is set (add ! to override)", 0)
      else
        execute 'w!' | execute mvbuf | execute 'bd!' curbuf
      endif
    elseif a:force
      execute mvbuf | execute 'bd!' curbuf
    else
      call PrintError('No write since last change for buffer "' . bufname('%') . '"', 1)
    endif
  else
    execute mvbuf | execute 'bd' curbuf
  endif
endfunction

function! NextBuf()
  if IsCurrentBufferNERDTree()
    execute "normal \<C-W>\<C-w>"
  else
    bn
  endif
endfunction

function! PrevBuf()
  if IsCurrentBufferNERDTree()
    execute "normal \<C-W>\<C-w>"
  else
    bp
  endif
endfunction

function! IsCurrentBufferNERDTree()
  if exists('g:NERDTreeCreator')
    let nerdtree_regex = g:NERDTreeCreator.BufNamePrefix().'*'
    return bufname('%') =~ nerdtree_regex
  endif
  return 0
endfunction

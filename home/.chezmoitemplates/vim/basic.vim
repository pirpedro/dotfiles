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
set omnifunc=syntaxcomplete#Complete "To use omni completion, type <C-X><C-O> while open in Insert mode. If matching names are found, a pop-up menu opens which can be navigated using the <C-N> and <C-P> keys.
set autoread                         " Set to auto read when a file is changed from the outside
au FocusGained,BufEnter * checktime
let mapleader = ","                  " With a map leader it's possible to do extra key combinations
                                     " like <leader>w saves the current file
nmap <leader>w :w!<cr>               " Fast saving
inoremap jk <ESC>                    " map jk to <ESC>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Replicates command w for W
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>

" Close current buffer (saving or not, forcing quit or not)
command! -bang Q :call CloseCurrentBuffer(<bang>0, 0)
command! -bang WQ :call CloseCurrentBuffer(<bang>0, 1)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set so=7                         " Set 7 lines to the cursor - when moving vertically using j/k
let $LANG='en'                   " Avoid garbled characters in Chinese language windows OS
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set wildmenu                      " Turn on the Wild menu
set wildmode=list:longest
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
set mat=2                      " How many tenths of a second to blink when matching brackets
set noerrorbells               " No annoying sound on errors
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1              " Add a bit extra margin to the 
set colorcolumn=80            " Add a visual red ruler"
set modeline                  " Respect modeline in files
set modelines=4
set ttyfast                   " Optimize for fast terminal connections
set gdefault                  " Add the g flag to search/replace by default
set number                    " Enable line numbers
set relativenumber
set showcmd " Show the (partial) command as it’s being typed
set scrolloff=3 " Start scrolling three lines before the horizontal window border


" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" TODO: organize documentation
set showmode
set noundofile
set linebreak
set nolist
set formatoptions=qrn1
set updatetime=250

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

if (has("nvim"))
  " For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
" Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
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
    set t_Co=256
    set guitablabel=%M\ %t
endif


set guifont=Fira\ Code:h14 " Use Fira Code as main font
set encoding=utf8          " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac       " Use Unix as the standard file type

" Change colors on vimdiff
highlight DiffAdd    gui=none guifg=bg guibg=#90D090
highlight DiffDelete gui=none guifg=bg guibg=#EC7C7C
highlight DiffChange gui=none guifg=bg guibg=#6090C0
highlight DiffText   gui=none guifg=bg guibg=#8FBFE7

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup " Turn backup off, since most stuff is in SVN, git etc. anyway...
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab     " Use spaces instead of tabs
set smarttab      " Be smart when using tabs ;)
set shiftwidth=2  " 1 tab == 2 spaces
set tabstop=2
set softtabstop=2
set lbr           " Linebreak on 500 characters
set tw=500
set ai            "Auto indent
set si            "Smart indent
set wrap          "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


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

" Switch between different windows by their direction
nnoremap <silent> <A-Down> <C-w>j| "switching to below window
nnoremap <silent> <A-Up> <C-w>k| "switching to above window
nnoremap <silent> <A-Right> <C-w>l| "switching to right window
nnoremap <silent> <A-Left> <C-w>h| "switching to left window

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

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
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Switch between different buffers by their direction
nnoremap <silent> <C-Right> :call NextBuf()<CR>
nnoremap <silent> <C-Left> :call PrevBuf()<CR>

" Exchange line position with Alt+k (line up) or Alt+j (line down)
nmap <A-k> ddkP
nmap <A-j> ddp

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
set laststatus=2   " Always show the status line

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
    " Triger `autoread` when files changes on disk
    " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

    " Notification after file change
    " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Map to copy to clipboard
vmap <C-c> "+y
vmap <C-v> "+p

" Arrows are unvimlike 
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

vnoremap . :norm.<CR>

nnoremap / /\v
vnoremap / /\v


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! GetCwd()
  if exists('g:NERDTree')
    return g:NERDTree.ForCurrentTab().getRoot().path.str()
  else
    return getcwd()
  endif
endfunction

function! PrintError(msg, prompt)
  echohl ErrorMsg | echo a:msg | echohl None
  if a:prompt
    echohl Question | echo "" | echohl None
  endif
endfunction

function! CloseCurrentBuffer(force, save)
  let curbuf = bufnr("%")
  let lastbuf = bufnr("$")
  let mvbuf = curbuf == lastbuf ? "bp" : "bn"
  if &mod
    if a:save
      if (&readonly && !a:force)
        call PrintError("'readonly' option is set (add ! to override)", 0)
      else
        exe 'w!' | exe mvbuf | exe 'bd! '.curbuf
      endif
    elseif a:force
      exe mvbuf | exe 'bd! '.curbuf
    else
      let curbufname = bufname("%")
      call PrintError("No write since last change for buffer \"".curbufname."\"", 1)
    endif
  else
    exe mvbuf | exe 'bd '.curbuf
  endif
endfunction

function! NextBuf()
  if IsCurrentBufferNERDTree()
    exe "normal \<C-W>\<C-w>"
  else
    exe 'bn'
  endif
endfunction

function! PrevBuf()
  if IsCurrentBufferNERDTree()
    exe "normal \<C-W>\<C-w>"
  else
    exe 'bp'
  endif
endfunction

function! IsCurrentBufferNERDTree()
  let nerdtree_regex = g:NERDTreeCreator.BufNamePrefix().'*'
  let current_buffer_name = bufname('%')
  return current_buffer_name =~ nerdtree_regex
endfunction
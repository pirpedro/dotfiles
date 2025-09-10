" ============================
" => NERDTree: sane auto-open + quit behavior
" ============================
augroup nerdtree_boot
  autocmd!
  " Mark stdin was used (e.g. `cat file | vim -`)
  autocmd StdinReadPre * let s:std_in = 1

  " Do all logic in a function to avoid inline-if parsing pitfalls
  autocmd VimEnter * call <SID>maybe_open_nerdtree_on_start()

  " Quit Vim if NERDTree is the only remaining window
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END

function! s:maybe_open_nerdtree_on_start() abort
  " Try to ensure the plugin is loaded (works com vim-plug)
  if exists('*plug#load')
    silent! call plug#load('nerdtree')
  endif
  " Como fallback absoluto, carregue o arquivo do plugin direto:
  if !exists(':NERDTree')
    silent! runtime plugin/NERD_tree.vim
  endif
  " Se ainda assim não existe, desista silenciosamente (plugin ausente)
  if !exists(':NERDTree')
    " Fallback: se abriu um diretório, só dá :Lexplore pra não quebrar
    if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in')
      execute 'cd ' . fnameescape(argv()[0])
      Lexplore
    endif
    return
  endif

  " Fluxo normal
  if argc() == 0 && !exists('s:std_in')
    silent! NERDTree | wincmd p
  elseif argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in')
    execute 'cd ' . fnameescape(argv()[0])
    execute 'NERDTree ' . fnameescape(argv()[0])
    wincmd p
  endif
endfunction

" NERDTree UI tweaks
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.DS_Store$', '\.terraform$', '\.git$']
let g:NERDTreeWinSize = 35
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" NERDTree keymaps
nnoremap <silent> <leader>nn :NERDTreeToggle<CR>
nnoremap <silent> <leader>nf :NERDTreeFind<CR>
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :NERDTreeFind<CR>

" ============================
" => FZF: files / ripgrep / buffers / help
" ============================
" Use ripgrep as default grep tool if available
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --glob\ '!.git'
  set grepformat=%f:%l:%c:%m
endif

" Define a nicer :Rg that respects .gitignore and shows line numbers
if executable('rg')
  command! -nargs=* -complete=file Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git" '.shellescape(<q-args>),
        \   1,
        \   fzf#vim#with_preview(),
        \   0)
endif

" FZF keymaps
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :Helptags<CR>
" Resume last FZF
nnoremap <silent> <leader><leader> :History<CR>

" ============================
" => vim-visual-multi: safer mappings (Ctrl-S often conflicts in terminals)
" ============================
let g:multi_cursor_use_default_mapping = 0
" Primary (works in most terminals)
let g:multi_cursor_start_word_key      = '<A-n>'
let g:multi_cursor_select_all_word_key = '<A-a>'
let g:multi_cursor_start_key           = 'g<A-n>'
let g:multi_cursor_select_all_key      = 'g<A-a>'
let g:multi_cursor_next_key            = '<A-n>'
let g:multi_cursor_prev_key            = '<A-p>'
let g:multi_cursor_skip_key            = '<A-x>'
let g:multi_cursor_quit_key            = '<Esc>'
" Secondary (keep your Ctrl-S set if your terminal supports it)
" let g:multi_cursor_start_word_key      = '<C-s>'
" let g:multi_cursor_next_key            = '<C-s>'

" ============================
" => surround.vim: keep your gettext helper (scoped)
" ============================
" Example: annotate selections with _("...")
" Visual mode only, buffer-local per filetype if needed
xnoremap <silent> Si S(i_<Esc>f)
autocmd FileType mako xnoremap <buffer> <silent> Si S"i${ _(<Esc>2f"a) }<Esc>

" ============================
" => Vimroom / Goyo (distraction-free)
" ============================
let g:goyo_width = 100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<CR>

" ============================
" => ALE: keep your linter/fixer setup (good defaults)
" ============================
let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'
let g:ale_virtualtext_cursor = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\  '*': ['trim_whitespace', 'remove_trailing_lines'],
\  'javascript': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'json': ['prettier'],
\  'yaml': ['prettier'],
\  'markdown': ['prettier'],
\  'python': ['black', 'isort'],
\  'terraform': ['terraform'],
\}

" Optional: limit ALE linters if you want strict control
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'go': ['go', 'golint', 'errcheck']
\}

" ============================
" => GitGutter: toggle + handy hunk maps (pair with Fugitive)
" ============================
let g:gitgutter_enabled = 0
nnoremap <silent> <leader>d :GitGutterToggle<CR>
" Stage/reset current hunk (requires Fugitive)
nnoremap <silent> ]c :GitGutterNextHunk<CR>
nnoremap <silent> [c :GitGutterPrevHunk<CR>
nnoremap <silent> <leader>hs :GitGutterStageHunk<CR>
nnoremap <silent> <leader>hr :GitGutterUndoHunk<CR>

" ============================
" => EditorConfig
" ============================
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" ============================
" => Fugitive: GBrowse to clipboard
" ============================
nnoremap <silent> <leader>v :.GBrowse!<CR>
xnoremap <silent> <leader>v :'<'>GBrowse!<CR>

" ============================
" => Devicons: folder/file glyphs
" ============================
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''

" ============================
" => Tagbar
" ============================
nnoremap <silent> <F8> :TagbarToggle<CR>

" ============================
" => Rooter (project auto-chdir)
" ============================
let g:rooter_patterns = ['.git', 'Makefile', 'package.json', 'pyproject.toml', 'setup.py', 'requirements.txt']

" ============================
" => Airline
" ============================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline_theme = 'dracula'

" ============================
" LSP + Completion (vim-lsp + asyncomplete)
" ============================

" Diagnostics signs (unicode-friendly)
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_error        = {'text': '✘'}
let g:lsp_signs_warning      = {'text': '▲'}
let g:lsp_signs_information  = {'text': 'i'}
let g:lsp_signs_hint         = {'text': '•'}

" Completion UI defaults (works well with asyncomplete)
set completeopt=menu,menuone,noselect
let g:asyncomplete_auto_popup       = 1
let g:asyncomplete_min_chars        = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_popup_delay      = 50
let g:asyncomplete_remove_duplicates= 1
let g:asyncomplete_pumheight        = 15

" Register buffer source once (kept, but in a tidy augroup)
augroup asyncomplete_setup
  autocmd!
  autocmd User asyncomplete_setup call asyncomplete#register_source(
        \ asyncomplete#sources#buffer#get_source_options({
        \   'name': 'buffer',
        \   'allowlist': ['*'],
        \   'completor': function('asyncomplete#sources#buffer#completor'),
        \ }))
augroup END

" Handy LSP keymaps (buffer-local on attach)
augroup lsp_keymaps
  autocmd!
  autocmd User lsp_buffer_enabled call s:lsp_buf_maps()
augroup END

function! s:lsp_buf_maps() abort
  " Go-to, hover, refs, rename, code actions, diagnostics nav
  nnoremap <silent><buffer> gd :LspDefinition<CR>
  nnoremap <silent><buffer> gr :LspReferences<CR>
  nnoremap <silent><buffer> gi :LspImplementation<CR>
  nnoremap <silent><buffer> gy :LspTypeDefinition<CR>
  nnoremap <silent><buffer> K  :LspHover<CR>
  nnoremap <silent><buffer> <leader>rn :LspRename<CR>
  nnoremap <silent><buffer> <leader>ca :LspCodeAction<CR>
  nnoremap <silent><buffer> [d :LspPreviousDiagnostic<CR>
  nnoremap <silent><buffer> ]d :LspNextDiagnostic<CR>
endfunction

" ----------------------------
" Server registrations (vim-lsp)
" Prefer modern language servers when available; fall back when needed.
" ----------------------------
augroup lsp_servers
  autocmd!
  " TypeScript / JavaScript
  if executable('typescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'ts-lsp',
          \ 'cmd': {server_info->['typescript-language-server','--stdio']},
          \ 'allowlist': ['javascript','javascript.jsx','typescript','typescript.tsx',
          \               'javascriptreact','typescriptreact'],
          \ })
  elseif executable('tsserver')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'tsserver',
          \ 'cmd': {server_info->['tsserver']},
          \ 'allowlist': ['javascript','javascript.jsx','typescript','typescript.tsx'],
          \ })
  endif

  " Python
  if executable('pyright-langserver')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyright',
          \ 'cmd': {server_info->['pyright-langserver','--stdio']},
          \ 'allowlist': ['python'],
          \ })
  elseif executable('pylsp')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pylsp',
          \ 'cmd': {server_info->['pylsp']},
          \ 'allowlist': ['python'],
          \ })
  endif

  " Terraform
  if executable('terraform-ls')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'terraform-ls',
          \ 'cmd': {server_info->['terraform-ls','serve']},
          \ 'allowlist': ['terraform','terraform.tf','terraform-vars'],
          \ })
  endif

  " YAML
  if executable('yaml-language-server')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'yamlls',
          \ 'cmd': {server_info->['yaml-language-server','--stdio']},
          \ 'allowlist': ['yaml'],
          \ })
  endif

  " HTML / CSS / JSON (VSCode servers; handle multiple binary names)
  if executable('vscode-html-language-server')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'html',
          \ 'cmd': {server_info->['vscode-html-language-server','--stdio']},
          \ 'allowlist': ['html'],
          \ })
  endif
  if executable('vscode-css-language-server')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'css',
          \ 'cmd': {server_info->['vscode-css-language-server','--stdio']},
          \ 'allowlist': ['css','scss'],
          \ })
  endif
  if executable('vscode-json-language-server')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'json',
          \ 'cmd': {server_info->['vscode-json-language-server','--stdio']},
          \ 'allowlist': ['json'],
          \ })
  endif

  " Bash
  if executable('bash-language-server')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'bashls',
          \ 'cmd': {server_info->['bash-language-server','start']},
          \ 'allowlist': ['sh','bash'],
          \ })
  endif

  " Dockerfile
  if executable('docker-langserver')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'dockerls',
          \ 'cmd': {server_info->['docker-langserver','--stdio']},
          \ 'allowlist': ['dockerfile'],
          \ })
  endif

  " Go
  if executable('gopls')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls']},
          \ 'allowlist': ['go'],
          \ })
  endif

  " Rust
  if executable('rust-analyzer')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'rust-analyzer',
          \ 'cmd': {server_info->['rust-analyzer']},
          \ 'allowlist': ['rust'],
          \ })
  endif

  " Lua
  if executable('lua-language-server')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'lua-ls',
          \ 'cmd': {server_info->['lua-language-server']},
          \ 'allowlist': ['lua'],
          \ })
  endif
augroup END

" Keep conflict-marker defaults (good with Git merges)
let g:conflict_marker_enable_mappings = 0

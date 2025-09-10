" chezmoi:template:left-delimiter="[["
" chezmoi:template:right-delimiter="]]"

" ============================
" Filetype-specific settings
" ============================
augroup ft_overrides
  autocmd!
  " ---------- Python ----------
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd FileType python setlocal textwidth=0 colorcolumn=88
  let g:python_highlight_all = 1
  " Abbreviations (safer than intrusive inoremap)
  autocmd FileType python iabbrev <buffer> rr return
  autocmd FileType python iabbrev <buffer> ii import
  autocmd FileType python iabbrev <buffer> pp print
  " Folding toggles
  autocmd FileType python nnoremap <buffer> <leader>fi :setlocal foldmethod=indent foldlevel=1<CR>
  autocmd FileType python nnoremap <buffer> <leader>fo :setlocal foldmethod=manual<CR>
  " Optional formatter for gq: use black if available
  autocmd FileType python if executable('black') | setlocal formatprg=black\ -q\ - | endif

  " ---------- JavaScript / TypeScript / React ----------
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab
  " Folding toggles
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact nnoremap <buffer> <leader>fi :setlocal foldmethod=indent foldlevel=2<CR>
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact nnoremap <buffer> <leader>fo :setlocal foldmethod=manual<CR>
  " Lightweight console.log helper via abbrev (keeps your Insert mode clean)
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact iabbrev <buffer> clg console.log(<C-R>=expand('%:t')<CR>, <C-R>=line('.')<CR>, )
  " Optional Prettier as formatprg (gq) if available
  autocmd FileType javascript,javascriptreact if executable('prettier') | setlocal formatprg=prettier\ --parser\ babel | endif
  autocmd FileType typescript,typescriptreact if executable('prettier') | setlocal formatprg=prettier\ --parser\ typescript | endif

  " ---------- JSON / YAML (incl. Ansible) ----------
  autocmd FileType json,yaml setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType yaml setlocal indentkeys-=0#       " keep comments from resetting indent
  autocmd FileType json if executable('prettier') | setlocal formatprg=prettier\ --parser\ json | endif
  " Ansible files are detected by plugin; prefer 2 spaces and linting via ALE

  " ---------- Terraform ----------
  autocmd FileType terraform setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType terraform setlocal commentstring=#\ %s
  autocmd FileType terraform nnoremap <buffer> <leader>v :!terraform validate<CR>
  " Let gq use 'terraform fmt -' if available (reads stdin)
  autocmd FileType terraform if executable('terraform') | setlocal formatprg=terraform\ fmt\ - | endif

  " ---------- Dockerfile ----------
  autocmd FileType dockerfile setlocal tabstop=2 shiftwidth=2 expandtab

  " ---------- Helm / gotmpl ----------
  autocmd FileType helm,gotmpl,yaml setlocal tabstop=2 shiftwidth=2 expandtab
  " Comment style for Helm templates
  autocmd FileType gotmpl setlocal commentstring={{-#\ %s\ -}}

  " ---------- Go ----------
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType go nnoremap <buffer> <leader>r :!go run %<CR>
  " Use gofmt/goimports with gq if available
  autocmd FileType go if executable('gofmt') | setlocal formatprg=gofmt | endif

  " ---------- Rust ----------
  autocmd FileType rust setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd FileType rust nnoremap <buffer> <leader>r :!cargo run<CR>
  autocmd FileType rust if executable('rustfmt') | setlocal formatprg=rustfmt | endif

  " ---------- Lua ----------
  autocmd FileType lua setlocal tabstop=2 shiftwidth=2 expandtab
  " Stylua formatting for gq if available
  autocmd FileType lua if executable('stylua') | setlocal formatprg=stylua\ - | endif

  " ---------- HTML / CSS / SCSS ----------
  autocmd FileType html,css,scss setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType html if executable('prettier') | setlocal formatprg=prettier\ --parser\ html | endif
  autocmd FileType css,scss if executable('prettier') | setlocal formatprg=prettier\ --parser\ css | endif

  " ---------- Markdown ----------
  let g:vim_markdown_folding_disabled = 1
  autocmd FileType markdown setlocal spell spelllang=pt_br,en
  autocmd FileType markdown setlocal wrap linebreak breakindent
  autocmd FileType markdown setlocal conceallevel=0

  " ---------- Git commit ----------
  autocmd FileType gitcommit setlocal spell spelllang=pt_br,en
  autocmd FileType gitcommit setlocal textwidth=72 colorcolumn=+1
  autocmd FileType gitcommit nnoremap <buffer> <leader>s :setlocal spell!<CR>

  " ---------- Templates (Jinja, Mako, Twig) ----------
  autocmd BufNewFile,BufRead *.jinja,*.j2 setlocal filetype=htmljinja
  autocmd BufNewFile,BufRead *.mako setlocal filetype=mako
  autocmd BufRead *.twig setlocal filetype=html
augroup END

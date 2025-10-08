" ---------- Conventional Commit (Angular) – Vim helper ----------

" 1) Web / SPA
let g:cc_scopes_web = [
      \ 'ui','ux','routing','state','forms','i18n','a11y',
      \ 'api','auth','storage','build','deps','tests','docs'
      \ ]

" 2) API / Backend
let g:cc_scopes_api = [
      \ 'auth','api','controller','service','repo','domain',
      \ 'db','migration','cache','queue','observability','config',
      \ 'build','deps','tests','docs'
      \ ]

" 3) CLI / Library
let g:cc_scopes_cli = [
      \ 'cli','parser','formatter','runtime','fs','http','config',
      \ 'api','docs','tests','build','deps'
      \ ]

" 4) DevOps / Infra
let g:cc_scopes_infra = [
      \ 'ci','release','docker','compose','k8s','helm','terraform',
      \ 'packaging','monitoring','logging','secrets','security','docs'
      \ ]

" 5) Data / ML
let g:cc_scopes_data = [
      \ 'schema','ingest','etl','pipeline','feature-store',
      \ 'training','inference','notebook','viz','jobs','infra','docs','tests'
      \ ]

" 6) Mobile
let g:cc_scopes_mobile = [
      \ 'ios','android','ui','navigation','networking','storage',
      \ 'notifications','deeplink','build','deps','tests','docs'
      \ ]

" 7) Minimal (universal)
let g:cc_scopes_min = [
      \ 'core','ui','api','auth','db','infra','build','ci','tests','docs'
      \ ]

" 8) Monorepo (example; replace with real package names)
let g:cc_scopes_monorepo = [
      \ 'web-app','admin-ui','account-api','billing-api','shared-lib',
      \ 'infra','build','ci','docs','tests'
      \ ]

" Default project scopes (fallback)
let g:cc_scopes = [
  \ 'core','ui','api','auth','db','infra','build','ci','tests','docs'
  \ ]

command! -nargs=1 CommitScopesUse exec 'let g:cc_scopes = copy(g:cc_scopes_' . <q-args> . ')'

" ==== Commitlint scopes → g:cc_scopes (only when assistant runs) ===========

" Get repo root: walk up until .git/ is found
function! s:RepoRoot() abort
  let gitdir = finddir('.git', '.;')
  if empty(gitdir)
    return ''
  endif
  return fnamemodify(gitdir, ':h')
endfunction

" Read a whole file into a single string
function! s:ReadAll(path) abort
  return join(readfile(a:path), "\n")
endfunction

" JSON: extract rules['scope-enum'][2]
function! s:ScopesFromJson(path) abort
  try
    let cfg = json_decode(s:ReadAll(a:path))
  catch
    return []
  endtry
  if type(cfg) != type({}) || !has_key(cfg, 'rules') | return [] | endif
  let rules = cfg.rules
  if has_key(rules, 'scope-enum') && type(rules['scope-enum']) == type([])
    let arr = rules['scope-enum']
    if len(arr) >= 3 && type(arr[2]) == type([])
      return filter(copy(arr[2]), 'type(v:val) == type("")')
    endif
  endif
  return []
endfunction

" Strip simple JS comments
function! s:StripJsComments(txt) abort
  let s = substitute(a:txt, '/\*.\{-}\*/', '', 'g') " /* ... */
  let s = substitute(s, '//[^\n]*', '', 'g')        " // ...
  return s
endfunction

" Extract all quoted strings (single/double), respecting escapes
function! s:ExtractQuotedStrings(inner) abort
  let s = a:inner
  let out = []
  let i = 0
  let n = strlen(s)
  while i < n
    let ch = s[i]
    if ch != '"' && ch != "'"
      let i += 1 | continue
    endif
    let q = ch
    let j = i + 1
    let buf = ''
    while j < n
      let c = s[j]
      if c == '\' && j+1 < n
        let buf .= s[j+1]
        let j += 2
        continue
      endif
      if c == q
        if index(out, buf) < 0 | call add(out, buf) | endif
        let i = j + 1
        break
      endif
      let buf .= c
      let j += 1
    endwhile
    if j >= n | break | endif
  endwhile
  return out
endfunction

" Scanner: find 3rd item (sub-array) of scope-enum and return its inner text (without [ ])
function! s:InnerScopesArrayLiteral(txt) abort
  let s = a:txt
  let mstart = match(s, '\v(scope-enum|''scope-enum''|"scope-enum")\s*:')
  if mstart < 0 | return '' | endif
  let i = match(s, '\[', mstart)
  if i < 0 | return '' | endif
  let n = strlen(s)
  let depth = 0
  let in_str = 0
  let q = ''
  let item_idx = -1
  let j = i
  while j < n
    let c = s[j]
    if in_str
      if c == '\' && j+1 < n | let j += 2 | continue | endif
      if c == q | let in_str = 0 | let q = '' | let j += 1 | continue | endif
      let j += 1 | continue
    else
      if c == '"' || c == "'"
        let in_str = 1 | let q = c | let j += 1 | continue
      endif
      if c == '['
        let depth += 1
        if depth == 1
          let item_idx = 0
        elseif depth == 2 && item_idx == 2
          let start = j + 1
          let subd = 1
          let k = start
          let in_s = 0 | let qs = ''
          while k < n
            let ck = s[k]
            if in_s
              if ck == '\' && k+1 < n | let k += 2 | continue | endif
              if ck == qs | let in_s = 0 | let qs = '' | let k += 1 | continue | endif
              let k += 1 | continue
            else
              if ck == '"' || ck == "'"
                let in_s = 1 | let qs = ck | let k += 1 | continue
              endif
              if ck == '[' | let subd += 1 | let k += 1 | continue | endif
              if ck == ']'
                let subd -= 1
                if subd == 0
                  return strpart(s, start, k - start)
                endif
                let k += 1 | continue
              endif
              let k += 1 | continue
            endif
          endwhile
          return ''
        endif
      elseif c == ']'
        let depth -= 1
        if depth == 0 | return '' | endif
      elseif c == ','
        if depth == 1
          let item_idx += 1
        endif
      endif
      let j += 1 | continue
    endif
  endwhile
  return ''
endfunction

" JS/CJS/MJS: extract scopes from a literal scope-enum array
function! s:ScopesFromJs(path) abort
  let raw = s:ReadAll(a:path)
  let txt = s:StripJsComments(raw)
  let inner = s:InnerScopesArrayLiteral(txt)
  if empty(inner)
    return []
  endif
  return s:ExtractQuotedStrings(inner)
endfunction

" Find commitlint config in repo root and return scopes (or [])
function! s:FindCommitlintScopes() abort
  let root = s:RepoRoot()
  if empty(root) | return [] | endif
  let candidates = [
        \ 'commitlint.config.cjs',
        \ 'commitlint.config.js',
        \ 'commitlint.config.mjs',
        \ '.commitlintrc.json',
        \ 'commitlint.config.json'
        \ ]
  for name in candidates
    let p = root . '/' . name
    if !filereadable(p) | continue | endif
    if name =~# '\.json$'
      let sc = s:ScopesFromJson(p)
    else
      let sc = s:ScopesFromJs(p)
    endif
    if !empty(sc)
      return sc
    endif
  endfor
  return []
endfunction

" Load commitlint scopes (if present), otherwise keep fallback
function! s:LoadProjectScopesFromCommitlint() abort
  let sc = s:FindCommitlintScopes()
  if !empty(sc)
    let sc = map(sc, 'tolower(substitute(v:val, ''\s\+'', ''-'', ''g''))')
    let g:cc_scopes = sc
  endif
endfunction

" ==== /Commitlint scopes ====================================================

" Types (Angular/Conventional)
let g:cc_types = [
      \ 'feat     – A new feature',
      \ 'fix      – A bug fix',
      \ 'docs     – Documentation only changes',
      \ 'style    – Changes that do not affect the meaning of the code',
      \ 'refactor – A code change that neither fixes a bug nor adds a feature',
      \ 'perf     – A code change that improves performance',
      \ 'test     – Adding missing tests or correcting existing tests',
      \ 'build    – Changes that affect the build system or external dependencies',
      \ 'ci       – Changes to our CI configuration files and scripts',
      \ 'chore    – Other changes that dont modify src or test files',
      \ 'revert   – Reverts a previous commit'
      \ ]

let g:issue_change_types = [
      \ 'Closes', 'Fixes', 'Refs', 'Resolves',
      \ ]

" UI highlight groups (titles/prompts)
highlight! default MyLabel     ctermfg=45  cterm=bold guifg=#00ffd7 gui=bold
highlight! default MyHint      ctermfg=8               guifg=#6b7280
highlight! default MyQuestion  ctermfg=33  cterm=bold guifg=#00aaff gui=bold
augroup CommitHiFix
  autocmd!
  autocmd ColorScheme * highlight! default MyLabel ctermfg=45 cterm=bold guifg=#00ffd7 gui=bold
  autocmd ColorScheme * highlight! default MyHint ctermfg=8 guifg=#6b7280
  autocmd ColorScheme * highlight! default MyQuestion ctermfg=33 cterm=bold guifg=#00aaff gui=bold
augroup END

" Detect commit buffers and set filetype
augroup GitCommitDetect
  autocmd!
  autocmd BufRead,BufNewFile COMMIT_EDITMSG,MERGE_MSG,SQUASH_MSG,REVERT_MSG setlocal filetype=gitcommit
  autocmd BufRead,BufNewFile */.git/commit_message.txt setlocal filetype=gitcommit
augroup END

" Visual setup (do NOT autoload scopes here)
augroup GitCommitAuto
  autocmd!
  autocmd FileType gitcommit call s:GitCommitSetup()
augroup END

function! s:GitCommitSetup() abort
  setlocal textwidth=72
  setlocal colorcolumn=51,73
  setlocal formatoptions+=t
  setlocal spell spelllang=en,pt_br
  setlocal nosmartindent
  " Jump between <++> placeholders (if you use templates)
  inoremap <buffer> <C-j> <Esc>/<++><CR>:nohlsearch<CR>c4l
  nnoremap <buffer> <C-j> /<++><CR>:nohlsearch<CR>c4l
  inoremap <buffer> <C-k> <Esc>?<++><CR>:nohlsearch<CR>c4l
  nnoremap <buffer> <C-k> ?<++><CR>:nohlsearch<CR>c4l
  " Manual shortcut to launch the assistant
  nnoremap <buffer> <leader>gc :CommitC<CR>
endfunction

" --- UI helpers ---
function! s:msg(group, text) abort
  execute 'echohl ' . a:group
  echomsg a:text
  echohl None
endfunction

function! s:_pick(label, opts) abort
  echohl MyLabel | echomsg a:label | echohl None
  echohl MyHint  | echomsg 'Choose a number and press <Enter>.' | echohl None
  let l:menu = map(copy(a:opts), 'printf("%d. %s", v:key+1, v:val)')
  let l:old_ch = &cmdheight
  if has('nvim') && &cmdheight == 0 | set cmdheight=1 | endif
  " Temporarily link 'Question' to our color for inputlist
  let l:q_dump = execute('silent highlight Question')
  let l:q_link = matchstr(l:q_dump, 'links to \zs\S\+')
  let l:q_had_link = (l:q_link !=# '')
  highlight! link Question MyQuestion
  call inputsave()
  let l:idx = inputlist(l:menu)
  call inputrestore()
  " Restore previous highlight for 'Question'
  if l:q_had_link
    execute 'highlight! link Question ' . l:q_link
  else
    highlight clear Question
  endif
  let &cmdheight = l:old_ch
  echo "\n"
  if l:idx < 1 || l:idx > len(a:opts) | return '' | endif
  return a:opts[l:idx-1]
endfunction

function! s:_yesno(label) abort
  echohl MyLabel | echomsg a:label | echohl None
  let l:ans = confirm("Select:", "&No\n&Yes", 1)
  echo "\n"
  return l:ans == 2
endfunction

function! s:_type_key(line) abort
  return matchstr(a:line, '^\w\+')
endfunction

function! s:_ask_subject() abort
  call s:msg('MyLabel', 'Subject (<=50 chars, imperative, no period):')
  let s = input("> ")
  echo "\n"
  if len(s) > 50
    echohl WarningMsg | echom 'Subject has ' . len(s) . ' chars (limit 50).' | echohl None
  endif
  return substitute(s, '\.\s*$', '', '')
endfunction

" Normalize issues input: '31, #4  7' -> ['#31', '#4', '#7'] (dedup)
function! s:_normalize_issues(s) abort
  let txt   = substitute(a:s, '[,;]', ' ', 'g')
  let parts = split(txt)
  let acc   = []
  for p in parts
    let t = trim(p)
    if empty(t)
      continue
    endif
    if t =~# '^\d\+$'
      let id = '#' . t
    elseif t =~# '^#\d\+$'
      let id = t
    else
      let id = t
    endif
    if index(acc, id) < 0
      call add(acc, id)
    endif
  endfor
  return acc
endfunction

" Ensure one blank line before trailers and append 'KEY: value'
function! s:_append_trailer(key, value) abort
  if empty(a:value)
    return
  endif
  let last = line('$')
  let nb   = prevnonblank(last)
  if nb == 0 || nb == last
    call append(last, '')
  endif
  call append(line('$'), a:key . ': ' . a:value)
endfunction

" Assistant
command! CommitC call CommitConventional()
function! CommitConventional() abort
  if &filetype !=# 'gitcommit' | setlocal filetype=gitcommit | endif

  " ← Load commitlint scopes only now
  call s:LoadProjectScopesFromCommitlint()

  " 1) type
  let tline = s:_pick('Select the type of change that you are committing:', g:cc_types)
  if empty(tline) | echo 'Aborted: empty type.' | return | endif
  let type = s:_type_key(tline)

  " 2) scope
  let scope = ''
  if !empty(g:cc_scopes)
    let pick = s:_pick('Denote the SCOPE of this change (optional):', ['(none)'] + g:cc_scopes)
    if pick !=# '' && pick !=# '(none)' | let scope = pick | endif
  endif
  call s:msg('MyLabel', 'Custom scope (Enter to keep "' . (empty(scope)?'':scope) . '"): ')
  let manual = input('> ')
  echo "\n"
  if !empty(manual) | let scope = manual | endif

  " 3) breaking?
  let breaking = s:_yesno('Breaking change?')

  " 4) subject
  let subject = s:_ask_subject()
  if empty(subject) | echo 'Aborted: empty subject.' | return | endif

  let header_preview = type
        \ . (empty(scope) ? '' : '(' . scope . ')')
        \ . (breaking ? '!' : '')
        \ . ': ' . subject
  if strdisplaywidth(header_preview) > 50
    echohl WarningMsg
    echom 'Header > 50 cols (' . strdisplaywidth(header_preview) . '). Shorten the subject or scope.'
    echohl None
  endif

  " 5) body
  call s:msg('MyLabel', "Body (optional). Type lines; blank line to finish:")
  let body = []
  while 1
    let ln = input('> ')
    if empty(ln) | break | endif
    call add(body, ln)
  endwhile

  " 6) Issues (footer)
  let issues_type = ''
  if exists('g:issue_change_types') && !empty(g:issue_change_types)
    let pick = s:_pick('Select the ISSUES type of change:', ['(none)', '(custom)'] + g:issue_change_types)
    if pick ==# '(custom)'
      let issues_type = input('Custom ISSUES type (Enter to skip): ')
    elseif pick !=# '' && pick !=# '(none)'
      let issues_type = pick
    endif
  else
    call s:msg('MyLabel', 'Select the ISSUES type of change (or leave blank):')
    let issues_type = input("> ")
  endif
  echo "\n"
  if !empty(issues_type)
    let issues_type = substitute(toupper(trim(issues_type)), '\s\+', '-', 'g')
  endif

  let issues_ids = []
  if !empty(issues_type)
    call s:msg('MyLabel', 'List any ISSUES AFFECTED by this change. E.g.: #31, #4')
    call inputsave()
    let raw = input('> ')
    call inputrestore()
    let issues_ids = s:_normalize_issues(raw)
  endif

  let trailer_issues = ''
  if !empty(issues_ids)
    let trailer_issues = join(issues_ids, ', ')
  endif

  " Header + body
  silent %delete _
  call setline(1, header_preview)
  if !empty(body)
    call append(line('$'), '')
    call append(line('$'), body)
  endif

  " Reflow (from line 3 down)
  if line('$') > 2
    execute 'silent keepjumps 3,' . line('$') . 'norm! gq'
  endif

  " Footers
  if !empty(trailer_issues)
    call s:_append_trailer(issues_type, trailer_issues)
  endif
  let has_breaking = (join(body, "\n") =~? '\v(^|\n)\s*BREAKING(-| )CHANGE:')
  if breaking && !has_breaking
    call s:_append_trailer('BREAKING CHANGE', 'describe the impact and migration.')
  endif

  normal! gg$
endfunction

" Auto-run assistant only if buffer contains just template/comments
function! s:AutoCommitWizard() abort
  if get(b:, 'cc_started', 0) | return | endif
  let payload = filter(getline(1,'$'), 'v:val !~ "^\\s*#\\|^\\s*$"')
  if empty(payload)
    let b:cc_started = 1
    silent! call CommitConventional()
  endif
endfunction

" Clean placeholders like <++> on write
augroup GitCommitUXClean
  autocmd!
  autocmd BufWritePre * if &filetype ==# 'gitcommit' | silent! %s/<\+\+>//ge | endif
augroup END

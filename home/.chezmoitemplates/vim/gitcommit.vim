" ---------- Git commit UX ----------
augroup GitCommitUX
  autocmd!
  " Apply only in gitcommit buffers
  autocmd FileType gitcommit call s:GitCommitSetup()
augroup END

function! s:GitCommitSetup() abort
  " Visual rules for good commit messages
  setlocal textwidth=72              " wrap body at 72
  setlocal colorcolumn=51,73         " guides: subject 50, body 72
  setlocal formatoptions+=t          " auto-wrap as you type in body
  setlocal spell spelllang=pt_br,en  " bilingual spellcheck
  setlocal nosmartindent             " keep indentation simple for text

  " Jump between <++> placeholders and start replacing (Insert + select)
  " In Insert mode: Ctrl-j jumps to next <++> and puts you editing it
  inoremap <buffer> <C-j> <Esc>/<++><CR>:nohlsearch<CR>c4l
  " In Normal mode: Ctrl-j faz o mesmo
  nnoremap <buffer> <C-j> /<++><CR>:nohlsearch<CR>c4l

  " Quick fill of header line via prompts:
  " <leader>c asks for type/scope/summary and writes line 1 correctly
  nnoremap <buffer> <leader>c :call <SID>FillHeader()<CR>
endfunction

" Completion list for conventional commit types
function! CommitTypes(A, L, P) abort
  return ['feat','fix','docs','style','refactor','test','chore','perf','build','ci','revert']
endfunction

function! s:FillHeader() abort
  let l:type = input('type: ', '', 'customlist,CommitTypes')
  if empty(l:type)
    echo "Aborted: type vazio."
    return
  endif
  let l:scope = input('scope (opcional): ')
  let l:summary = input('summary: ')
  if empty(l:summary)
    echo "Aborted: summary vazio."
    return
  endif
  let l:head = l:type . (empty(l:scope) ? '' : '(' . l:scope . ')') . ': ' . l:summary
  " Put on first line (subject) and move cursor to body
  call setline(1, l:head)
  normal! 2G
endfunction

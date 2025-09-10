"=================================================================================
"
"   Following file contains the commands on how to run the currently open code.
"   The default mapping is set to F5 like most code editors.
"   Change it as you feel comfortable with, keeping in mind that it does not
"   clash with any other keymapping.
"
"   NOTE: Compilers for different systems may differ. For example, in the case
"   of C and C++, we have assumed it to be gcc and g++ respectively, but it may
"   not be the same. It is suggested to check first if the compilers are installed
"   before running the code, or maybe even switch to a different compiler.
"
"   NOTE: Adding support for more programming languages
"
"   Just add another elseif block before the 'endif' statement in the same
"   way it is done in each case. Take care to add tabbed spaces after each
"   elseif block (similar to python). For example:
"
"   elseif &filetype == '<your_file_extension>'
"       exec '!<your_compiler> %'
"
"   NOTE: The '%' sign indicates the name of the currently open file with extension.
"         The time command displays the time taken for execution. Remove the
"         time command if you dont want the system to display the time
"
"=================================================================================

" Keymaps (safer: noremap + silent)
nnoremap <silent> <F5> :call CompileRun()<CR>
inoremap <silent> <F5> <Esc>:call CompileRun()<CR>
vnoremap <silent> <F5> <Esc>:call CompileRun()<CR>

" Toggle to add 'time -p' before run commands
let g:compile_use_time = 1

function! s:has_term() abort
  return has('terminal')
endfunction

function! s:timewrap(cmd) abort
  if get(g:, 'compile_use_time', 0)
    " Use POSIX time if available; otherwise just run the command.
    return 'sh -lc ' . shellescape('command -v time >/dev/null 2>&1 && time -p ' . a:cmd . ' || ' . a:cmd)
  endif
  return a:cmd
endfunction

function! s:term_exec(cmd) abort
  if s:has_term()
    " Open a bottom split terminal and run the command via shell
    botright 12split
    execute 'terminal' a:cmd
    " Optional: start in normal mode; comment next line if you prefer insert-mode
    stopinsert
  else
    " Fallback for very old Vim: blocking shell
    execute '!' . a:cmd
  endif
endfunction

function! s:run_build_and_exec(build, run) abort
  let l:cmd = ''
  if !empty(a:build)
    let l:cmd = a:build . ' && ' . a:run
  else
    let l:cmd = a:run
  endif
  call s:term_exec(s:timewrap(l:cmd))
endfunction

function! s:open_html(file) abort
  if has('win32') || has('win64')
    return 'start ' . shellescape(a:file)
  elseif has('macunix')
    return 'open ' . shellescape(a:file)
  else
    return 'xdg-open ' . shellescape(a:file)
  endif
endfunction

function! s:has_shebang_exec(file) abort
  if !filereadable(a:file)
    return 0
  endif
  let l:first = getline(1)
  let l:perm = getfperm(a:file)
  return l:first =~# '^#!' && l:perm =~# 'x'
endfunction

function! CompileRun() abort
  " Save current buffer
  write

  let l:file = expand('%:p')
  let l:base = expand('%:t:r')          " filename without extension
  let l:ft   = &filetype
  let l:exe  = ''

  " If file is an executable script with shebang, just run it.
  if s:has_shebang_exec(l:file)
    call s:term_exec(s:timewrap(shellescape(l:file)))
    return
  endif

  " Project-aware shortcuts
  if filereadable('Makefile') || filereadable('makefile')
    call s:term_exec(s:timewrap('make -j'))
    return
  endif

  if l:ft ==# 'rust'
    if filereadable('Cargo.toml')
      call s:term_exec(s:timewrap('cargo run'))
    else
      let l:build = 'rustc ' . shellescape(l:file) . ' -o ' . shellescape(l:base)
      let l:run   = './' . shellescape(l:base)
      call s:run_build_and_exec(l:build, l:run)
    endif
    return
  endif

  " Language-specific compile/run
  if l:ft ==# 'c'
    let l:build = 'gcc -O2 -Wall ' . shellescape(l:file) . ' -o ' . shellescape(l:base)
    let l:run   = './' . shellescape(l:base)
    call s:run_build_and_exec(l:build, l:run)

  elseif l:ft ==# 'cpp'
    let l:build = 'g++ -O2 -Wall ' . shellescape(l:file) . ' -o ' . shellescape(l:base)
    let l:run   = './' . shellescape(l:base)
    call s:run_build_and_exec(l:build, l:run)

  elseif l:ft ==# 'java'
    " Run class in CWD; ensure classpath is current dir
    let l:build = 'javac ' . shellescape(l:file)
    let l:run   = 'java -cp ' . shellescape(expand('%:p:h')) . ' ' . shellescape(l:base)
    call s:run_build_and_exec(l:build, l:run)

  elseif l:ft ==# 'go'
    " Prefer go run (fast feedback); switch to build+run if you prefer
    call s:term_exec(s:timewrap('go run ' . shellescape(l:file)))

  elseif l:ft ==# 'python'
    call s:term_exec(s:timewrap('python3 -u ' . shellescape(l:file)))

  elseif l:ft ==# 'sh' || l:ft ==# 'bash' || l:ft ==# 'zsh'
    " Respect the filetype shell
    let l:shell = (l:ft ==# 'zsh') ? 'zsh' : 'bash'
    call s:term_exec(s:timewrap(l:shell . ' ' . shellescape(l:file)))

  elseif l:ft ==# 'lua'
    call s:term_exec(s:timewrap('lua ' . shellescape(l:file)))

  elseif l:ft ==# 'javascript'
    " Prefer node; if package.json has scripts.test, you may switch to npm test
    call s:term_exec(s:timewrap('node ' . shellescape(l:file)))

  elseif l:ft ==# 'typescript'
    if executable('ts-node')
      call s:term_exec(s:timewrap('ts-node ' . shellescape(l:file)))
    elseif executable('tsc')
      " Compile to JS next to file and run
      let l:jsout = shellescape(l:base . '.js')
      call s:term_exec(s:timewrap('tsc ' . shellescape(l:file) . ' && node ' . l:jsout))
    else
      echoerr 'Neither ts-node nor tsc found in PATH.'
    endif

  elseif l:ft ==# 'html'
    call s:term_exec(s:timewrap(s:open_html(l:file)))

  elseif l:ft ==# 'yaml'
    " If it's an Ansible playbook, lint; otherwise try yamllint if installed
    if executable('ansible-lint')
      call s:term_exec(s:timewrap('ansible-lint ' . shellescape(l:file)))
    elseif executable('yamllint')
      call s:term_exec(s:timewrap('yamllint ' . shellescape(l:file)))
    else
      echo 'No YAML linter found; nothing to run.'
    endif

  elseif l:ft ==# 'terraform'
    " Basic validate cycle; customize as you wish
    call s:term_exec(s:timewrap('terraform fmt -diff && terraform validate'))

  else
    echo 'No CompileRun handler for filetype: ' . l:ft
  endif
endfunction

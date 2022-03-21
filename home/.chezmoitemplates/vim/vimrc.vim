" vi: filetype=vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Pedro Rodrigues — @pirpedro
"
" Enhanced by: https://github.com/amix/vimrc
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let &t_ut=''

{{ template "vim/plugins.vim" }}
{{ template "vim/basic.vim" }}
{{ template "vim/filetypes.vim" }}
{{ template "vim/plugins_config.vim" }}

{{ template "vim/open_file_under_cursor.vim"}}
{{ template "vim/compile.vim"}}
bind 'set mark-symlinked-directories on' 2>/dev/null

fzf_marks= $HOME/.local/share/zprezto/contrib/fzf-marks/fzf-marks.plugin.bash
if [ -e "$fzf_marks" ]; then
  source "$fzf_marks"
fi

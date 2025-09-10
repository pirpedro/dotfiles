#   ---------------------------
#   ENVIRONMENT (SAFE FOR SCRIPTS)
#   ---------------------------

#   XDG base dirs (do not print; safe defaults)
#   ------------------------------------------------------------
: "${XDG_CONFIG_HOME:={{.xdg.config}}}"
: "${XDG_CACHE_HOME:={{.xdg.cache}}}"
: "${XDG_DATA_HOME:={{.xdg.data}}}"
: "${XDG_STATE_HOME:={{.xdg.state}}}"
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME

#   Core PATH (user-first)
#   ------------------------------------------------------------
add_path "{{ .xdg.bin }}"
add_path "$HOME/bin"

#   Optional per-host path (example)
#   ------------------------------------------------------------

{{ includeTemplate "lib/export_node.tmpl" . }}
{{ includeTemplate "lib/export_python.tmpl" . }}

#asdf
export ASDF_DATA_DIR="{{ .xdg.data }}/asdf"
add_path "{{ .xdg.data }}/asdf/shims"
{{ includeTemplate "lib/export_cargo.tmpl" . }}
{{ includeTemplate "lib/export_go.tmpl" . }}
{{ includeTemplate "lib/expose_bins.tmpl" . }}


#   De-duplicate PATH segments
#   ------------------------------------------------------------
dedupe_path

#   # Locale & pager (script-safe)
#   ------------------------------------------------------------
: "${LANG:={{ .language }}}"
: "${LC_ALL:=$LANG}"
: "${PAGER:=less}"
export LANG LC_ALL PAGER

#   Editors
#   ------------------------------------------------------------

EDITOR="$(which_bin {{ .editor.terminal }} vim)"
VISUAL="$(which_bin {{ .editor.gui }} || code gedit)"
SHELL_IDE="$(which_bin {{ .editor.gui }} vim)"
export EDITOR VISUAL SHELL_IDE

#   Default Programs
#   ------------------------------------------------------------
BROWSER="$(which_bin {{ .browser }} firefox)"
export BROWSER

{{ if not .is.ephemeral }}
export NPM_CONFIG_USERCONFIG="{{ .xdg.config }}/npm/npmrc"
{{ end }}

if command_exists corepack; then
  corepack enable >/dev/null 2>&1 || true
fi

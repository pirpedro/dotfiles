binary="yq_{{- .chezmoi.os -}}_{{- .chezmoi.arch -}}"
wget https://github.com/mikefarah/yq/releases/download/v4.23.1/"${binary}".tar.gz -O - | tar xz && mv "${binary}" "$HOME"/.local/bin/yq

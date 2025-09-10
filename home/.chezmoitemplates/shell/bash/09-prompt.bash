#   -------------------------------
#   PROMPT
#   -------------------------------


# if command_exists starship ; then
#   eval "$(starship init bash)"
#   return
# fi

if command_exists oh-my-posh ; then
  eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/theme.toml)"
fi

if command_exists direnv ; then
  eval "$(direnv hook bash)"
fi

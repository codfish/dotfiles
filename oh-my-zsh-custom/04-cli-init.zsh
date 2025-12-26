# setting for pyenv
if type 'pyenv' &> /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# fnm
FNM_PATH="$(brew --prefix)/opt/fnm/bin"
if [ -d "$FNM_PATH" ] && ! type 'volta' &> /dev/null; then
  eval "`fnm env --use-on-cd --shell zsh`"
fi

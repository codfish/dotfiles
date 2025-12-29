# set 256 color profile where possible
if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

# Make vim the default editor
export EDITOR="vim"

# Ignore duplicate commands in the history
export HISTCONTROL=ignoredups

# Increase the maximum number of lines contained in the history file
# (default is 500)
export HISTFILESIZE=10000

# Increase the maximum number of commands to remember
# (default is 500)
export HISTSIZE=10000

# Don't clear the screen after quitting a manual page
export MANPAGER="less -X"

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# set prompt colors
export CLICOLOR=1
export GREP_OPTIONS="--color=auto"
export LSCOLORS=gxfxcxdxbxegedabagacad # Dark lscolor scheme

# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# For compilers to find libpq (postgres) you may need to set:
export LDFLAGS="-L/usr/local/opt/libpq/lib"
export CPPFLAGS="-I/usr/local/opt/libpq/include"

# For pkg-config to find libpq (postgres) you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/libpq/lib/pkgconfig"

# Disable automatic brew cleanup. Unexpected cleanups when trying to install something
export HOMEBREW_NO_INSTALL_CLEANUP=1

# Turn off homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# Set brew prefix once for reuse later so we don't need to keep re-running
# `brew --prefix`, which can be slow in certain environments
export BREW_PREFIX=$(brew --prefix)

# Set the config path for the cheat cli
# https://github.com/cheat/cheat/blob/d34177729d3369da9d74756f8cf3a762bd96604c/INSTALLING.md#confyml
export CHEAT_CONFIG_PATH="~/.dotfiles/cheat/conf.yml"

# needed this for docker to work on m2
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# android
export ANDROID_HOME="$HOME/Library/Android/sdk"

# ruby
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# volta
export VOLTA_HOME="$HOME/.volta"

# https://superuser.com/questions/365847/where-should-the-xdg-config-home-variable-be-defined
export XDG_CONFIG_HOME="$DOTFILES/.config"

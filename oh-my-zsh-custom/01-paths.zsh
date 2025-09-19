# Directories to be prepended to PATH
declare -a dirs_to_prepend=(
  # Volta - https://github.com/volta-cli/volta
  "$HOME/.volta/bin"

  # Homebrew bin paths on M1 macs
  "/opt/homebrew/bin"
  "/opt/homebrew/opt"

  # Ensure that this bin always takes precedence over `/usr/bin`
  "/usr/local/bin"

  # Mountain Lion comes with php-fpm pre-installed, to ensure you are using the
  #   brew version you need to make sure /usr/local/sbin is before /usr/sbin
  "/usr/local/sbin"

  # Use brew python instead of shipped version
  "/usr/local/opt/python@3/libexec/bin"

  # postgres libpq
  "/usr/local/opt/libpq/bin"

  # Home bin
  "$HOME/.local/bin"

  # Ruby
  "/opt/homebrew/opt/ruby/bin"

  # ios
  "$HOME/.fastlane/bin"
)

# Prepend directories to PATH
for index in ${dirs_to_prepend[@]}
do
  if [ -d $index ]; then
    # If these directories exist, then prepend them to existing PATH
    PATH="${index}:$PATH"
  fi
done

# Directories to be appended to PATH
declare -a dirs_to_append=(
  "/usr/bin"
  "$HOME/bin"
  "$HOME/.dotfiles/bin"
  "$(brew --prefix)/opt/coreutils/libexec/gnubin" # Add brew-installed GNU core utilities bin
  "$HOME/.composer/vendor/bin"
  "/Applications/Docker.app/Contents/Resources/bin"

  # android
  "/Library/Android/sdk/emulator"
  "/Library/Android/sdk/platform-tools"
)

# Append directories to PATH
for index in ${dirs_to_append[@]}
do
  if [ -d $index ]; then
    # If these bins exist, then append them to existing PATH
    PATH="$PATH:${index}"
  fi
done

fpath+=("$(brew --prefix)/share/zsh/site-functions")

unset dirs_to_prepend dirs_to_append

export PATH

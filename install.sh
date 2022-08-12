#!/bin/sh

set -e

# Settings
DOTFILES="${HOME}/.dotfiles"
ZSH="$DOTFILES/oh-my-zsh"
ZSH_CUSTOM="${DOTFILES}/oh-my-zsh-custom"

# Overridable settings
DOTFILES_REPO=${DOTFILES_REPO:-codfish/dotfiles}
DOTFILES_TARBALL_PATH="https://github.com/${DOTFILES_REPO}/tarball/main"

# Before relying on Homebrew, check that packages can be compiled
if ! type 'gcc' &> /dev/null; then
  e_error "The XCode Command Line Tools must be installed first."
  printf "  Run `sudo xcode-select --install` or download them directly\n"
  printf "  from: https://developer.apple.com/downloads\n"
  printf "  Then re-run the install script.\n"
  exit 1
fi

# If missing, download and extract the dotfiles repository
if [[ ! -d ${DOTFILES} ]]; then
  printf "$(tput setaf 7)Downloading dotfiles...\033[m\n"
  mkdir ${DOTFILES}
  # Get the tarball
  curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOTFILES_TARBALL_PATH}
  # Extract to the dotfiles directory
  tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOTFILES}
  # Remove the tarball
  rm -rf ${HOME}/dotfiles.tar.gz
fi

cd ${DOTFILES}
source ./lib/utils

# Check for Homebrew
if ! type 'brew' &> /dev/null; then
  e_header "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # make `brew` command available for M1 macs
  if is_m1; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# Check for git
if ! type 'git' &> /dev/null; then
  e_header "Updating Homebrew..."
  brew update
  e_header "Installing Git..."
  brew install git
fi

# Initialize the git repository if it's missing
if ! is_git_repo; then
  e_header "Initializing git repository..."
  git init
  git remote add origin https://github.com/${DOTFILES_REPO}
  git checkout -b main
  git fetch origin main
  # Reset the index and working tree to the fetched HEAD
  git reset --hard FETCH_HEAD
fi

# store DOTFILES_REPO env var in custom zsh script for syncing later
echo "export DOTFILES_REPO=${DOTFILES_REPO}" > $ZSH_CUSTOM/00-dotfiles.zsh

# If missing, download and extract the ohmyzsh repository
if [[ ! -d ${ZSH} ]]; then
  ZSH="$ZSH" RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# run the dotfiles for the first time
zsh bin/dotfiles

zsh -l

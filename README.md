# Dotfiles

> My macOS dotfiles for Zsh.

## Features

**Note:** Installation of `Oh My Zsh` is not optional. Everything else listed
below can be opted-out of.

- Installs Oh My Zsh with custom [exports](oh-my-zsh-custom/02-exports.zsh), [aliases](oh-my-zsh-custom/03-aliases.zsh), and [paths](oh-my-zsh-custom/01-paths.zsh).
- Loads a [selection of omz plugins](dotfiles/zshrc#L66) and [custom functions](functions).
- Installs custom "dotfiles":
  - [`.curlrc`](dotfiles/curlrc)
  - [`.gemrc`](dotfiles/gemrc)
  - [`.gitattributes`](dotfiles/gitattributes)
  - [`.gitconfig`](dotfiles/gitconfig)
  - [`.gitignore`](dotfiles/gitignore)
  - [`.zshrc`](dotfiles/zshrc)
- Installs Homebrew, fnm & latest version of node, composer & latest version of php
- Installs selection of brew formulae & node packages
- Runs `brew update`, `brew upgrade` and `brew cleanup`
- Optionally set custom [macOS defaults](bin/macosdefaults) with `--configure-macos` flag
- Optionally install Applications via `brew cask` with `--install-casks` flag

## Installation

This install is intended for macOS and requires the [Xcode Command Line Tools](https://developer.apple.com/downloads).
It may overwrite existing dotfiles in `$HOME` (and potentially `.vim`-related files), so skim `install.sh` first if you have an existing setup.

```sh
curl https://raw.githubusercontent.com/codfish/dotfiles/main/install.sh | bash
```

> [!IMPORTANT]
>
> If you're provisioning a new machine, you can also apply my macOS defaults (see [`bin/macosdefaults`](./bin/macosdefaults)) and install the optional GUI apps (see [`lib/brew`](./bin/brew)):
>
>   ```sh
>   curl https://raw.githubusercontent.com/codfish/dotfiles/main/install.sh | bash -s -- --configure-macos --install-casks
>   ```

### Forks

If you fork this repo and want the installer to pull from your fork:

```sh
DOTFILES_REPO=yourhandle/dotfiles curl https://raw.githubusercontent.com/codfish/dotfiles/main/install.sh | bash
```

Or just update the default value of `DOTFILES_REPO` in your fork and install from your repo.

### First Time Setup

After running the installation script on a new machine, there are several manual steps to complete the setup. These are personal preferences and may differ for your setup.

1. **1Password / SSH**
   - Login to 1Password
   - Update 1Password settings & enable SSH key management (for git authentication)
   - Create development directory & test 1Password SSH agent is working
      ```sh
      mkdir ~/Sites
      git clone git@github.com:codfish/semantic-release-action.git ~/Sites/semantic-release-action
      ```
2. **Cloud sync + shell config**
   - Login to Dropbox
   - Once Dropbox syncs, symlink your private zsh configuration:
     ```sh
     ln -s ~/Dropbox/configfiles/zshrc ~/.zshrc.before
     exec zsh
     ```
   - Login to Google Drive
1. **Open Alfred**
   - Activate Powerpack license
   - Update settings sync to point to Dropbox
1. **Setup Code Editors**
   - Sign into VS Code and enable Settings Sync
   - In Cursor, import settings & extensions from VS Code
1. **Todoist**
   - Sign into Todoist
   - Update Desktop settings to change keyboard shortcuts as needed
1. **AI CLI logins**
   ```sh
   claude login
   codex
   gemini
   ```

## Usage

Run the dotfiles command:

```sh
dotfiles
```

You should run the update when:

- You make a change to `~/.dotfiles/git/gitconfig` (the only file that is
  copied rather than symlinked).
- You want to pull changes from the remote repository.
- You want to update Homebrew formulae and Node packages.

Options:

<table>
    <tr>
        <td><code>-h</code>, <code>--help</code></td>
        <td>Help</td>
    </tr>
    <tr>
        <td><code>-l</code>, <code>--list</code></td>
        <td>List of additional applications to install</td>
    </tr>
    <tr>
        <td><code>--no-packages</code></td>
        <td>Skip package (brew/node/etc) updates</td>
    </tr>
    <tr>
        <td><code>--no-sync</code></td>
        <td>Skip pulling from the remote repository</td>
    </tr>
    <tr>
        <td><code>--configure-macos</code></td>
        <td>Configure macOS settings programatically</td>
    </tr>
    <tr>
        <td><code>--install-casks</code></td>
        <td>Install mac apps via brew cask (won't install/update if it's already present)</td>
    </tr>
</table>

## Oh My Zsh

These dotfiles essentially wrap [Oh My Zsh](https://ohmyz.sh/). When you install the dotfiles, Oh My Zsh will also get installed for you directly into the `~/.dotfiles` directory.

- `$ZSH` will be `~/.dotfiles/oh-my-zsh`
- `$ZSH_CUSTOM` will be `~/.dotfiles/oh-my-zsh-custom`
- Opinionated set of plugins are loaded
- Everything is configurable if you want to change things

### Oh My Zsh Plugins

- aws
- git
- iterm2
- history-substring-search
- z

## Homebrew formulae

- GNU core utilities
- [ack](http://betterthangrep.com/)
- awscli
- coreutils
- deno
- [git](http://git-scm.com/)
- go
- [heroku](https://devcenter.heroku.com/articles/heroku-cli)
- [jq](https://stedolan.github.io/jq/)
- MongoDB
- MySQL
- [nginx](https://www.nginx.com/)
- [nvm](https://github.com/creationix/nvm)
- [php](https://formulae.brew.sh/formula/php)
- python
- [rbenv](https://github.com/rbenv/rbenv) (and [ruby-build](https://github.com/rbenv/ruby-build))
- [rsync](https://rsync.samba.org/) (latest version, rather than the out-dated macOS installation)
- [tmux](https://github.com/tmux/tmux/wiki)
- [wget](http://www.gnu.org/software/wget/)

## Mac Applications Installed via Homebrew cask

- Alfred 4
- AppCleaner
- Brave Browser
- CloudApp
- Docker Desktop
- Express VPN
- Google Chrome
- Google Drive
- iTerm2
- Notion
- Postman
- Slack
- Spotify
- Visual Studio Code
- zoom.us

## Node packages

- [vercel](https://vercel.com/)
- [renamer](https://github.com/75lb/renamer)
- [npm-check](https://github.com/dylang/npm-check)

## Custom macOS defaults

Custom macOS settings can be applied during the `dotfiles` process. You'll be prompted before this happens so you can say no.

They can also be applied independently by running the following command:

```sh
macosdefaults
```

## Local/private

Any private and custom Bash commands and configuration should be placed in a
`~/.zshrc.before` or `~/.zshrc.after` file. These files will not be under
version control or committed to a public repository. If either or both exists,
they will be sourced for inclusion in `.zshrc`.

- `~/.zshrc.before`: Sourced **before** `oh-my-zsh.sh` is loaded, therefore allowing you to effect what happens when `oh-my-zsh.sh` runs, without changing any tracked files. Some examples would be the `ZSH_THEME` or specific Oh My Zsh plugin configurations.
- `~/.zshrc.after`: Sourced **after**  `oh-my-zsh.sh` is loaded. You can override anything that was set by `oh-my-zsh.sh`.

Here is an example `~/.zshrc.before`:

```sh
# PATH exports
PATH=$PATH:~/.gem/ruby/1.8/bin
export PATH

# Git credentials
# Not under version control to prevent people from
# accidentally committing with your details
GIT_AUTHOR_NAME="Chris O'Donnell"
GIT_AUTHOR_EMAIL="chris@example.com"

# Set the credentials (modifies ~/.gitconfig)
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Work Machine Aliases
alias web="cd ~/Sites/company/web"

ZSH_THEME="amuse"
```

Here is an example `~/.zshrc.after`:

```sh
# override something
alias ll="ls -aGlFh"
```

**Note:** Because the `dotfiles/gitconfig` file is copied to `~/.gitconfig`, any private
git configuration specified in `~/.zshrc.before` or `~/.zshrc.after` will not be committed to
your dotfiles repository.

## Acknowledgements

Inspiration and code was taken from many sources, including:

- [@necolas](https://github.com/necolas) (Nicolas Gallagher)
  [https://github.com/tejr/dotfiles] (https://github.com/necolas/dotfiles)
- [@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens)
  [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)

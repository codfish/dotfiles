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
- Installs Homebrew, volta & latest version of node, composer & latest version of php
- Installs selection of brew formulae & node packages
- Runs `brew update`, `brew upgrade` and `brew cleanup`
- Sets custom [macOS defaults](bin/macosdefaults)
- Installs Applications via `brew cask`

## Installation

The installation step requires the [XCode Command Line
Tools](https://developer.apple.com/downloads) and may overwrite existing
dotfiles in your HOME and `.vim` directories.

```sh
curl https://raw.githubusercontent.com/codfish/dotfiles/main/install.sh | bash
```

If you're provisioning a totally new machine and want to configure your macOS settings to match my preferences [defined here](bin/macosdefaults) and auto install the macOS apps via `brew cask` defined in [this file](lib/brew), you can pass the following flags:

```sh
curl https://raw.githubusercontent.com/codfish/dotfiles/main/install.sh | bash -sS -- --configure-macos --install-casks
```

If you wish to fork this project and maintain your own dotfiles, fork it and
run the following:

```sh
DOTFILES_REPO=yourhandle/dotfiles /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/yourhandle/dotfiles/main/install.sh)"
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
        <td><code>--no-macos</code></td>
        <td>Skip macOS settings update</td>
    </tr>
    <tr>
        <td><code>--with-apps</code></td>
        <td>Opt-in to install mac apps via brew cask (won't install/update if it's already present)</td>
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

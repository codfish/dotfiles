# Dotfiles

My macOS dotfiles. Based on [Nicolas Gallagher's dotfiles](https://github.com/necolas/dotfiles). (FYI I've added quite a bit though, but the foundation is still there).


## How to install

The installation step requires the [XCode Command Line
Tools](https://developer.apple.com/downloads) and may overwrite existing
dotfiles in your HOME and `.vim` directories.

```bash
$ bash -c "$(curl -fsSL raw.github.com/codfish/dotfiles/master/bin/dotfiles)"
```

N.B. If you wish to fork this project and maintain your own dotfiles, you must
substitute my username for your own in the above command and the 2 variables
found at the top of the `bin/dotfiles` script.

## How to update

You should run the update when:

* You make a change to `~/.dotfiles/git/gitconfig` (the only file that is
  copied rather than symlinked).
* You want to pull changes from the remote repository.
* You want to update Homebrew formulae and Node packages.

Run the dotfiles command:

```bash
$ dotfiles
```

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
        <td>Suppress package updates</td>
    </tr>
    <tr>
        <td><code>--no-sync</code></td>
        <td>Suppress pulling from the remote repository</td>
    </tr>
</table>


## Features

### Automatic software installation

Homebrew formulae:

* GNU core utilities
* [ack](http://betterthangrep.com/)
* bash (latest version)
* [bash-completion](http://bash-completion.alioth.debian.org/)
* [git](http://git-scm.com/)
* [heroku](https://devcenter.heroku.com/articles/heroku-cli)
* [jq](https://stedolan.github.io/jq/)
* [macvim](http://code.google.com/p/macvim/)
* MongoDB
* MySQL
* [nginx](https://www.nginx.com/)
* [nvm](https://github.com/creationix/nvm)
* [php](https://formulae.brew.sh/formula/php)
* [rbenv](https://github.com/rbenv/rbenv) (and [ruby-build](https://github.com/rbenv/ruby-build))
* [rsync](https://rsync.samba.org/) (latest version, rather than the out-dated macOS installation)
* [tmux](https://github.com/tmux/tmux/wiki)
* [tree](http://mama.indstate.edu/users/ice/tree/)
* [wget](http://www.gnu.org/software/wget/)
* [wp-cli](http://wp-cli.org/)

Node packages:

* [now](https://zeit.co/now)
* [yo](http://yeoman.io/)

Vim plugins:

* [ctrlp.vim](https://github.com/kien/ctrlp.vim)
* [html5.vim](https://github.com/othree/html5.vim)
* [syntastic](https://github.com/scrooloose/syntastic)
* [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
* [vim-git](https://github.com/tpope/vim-git)
* [vim-javascript](https://github.com/pangloss/vim-javascript)
* [vim-markdown](https://github.com/tpope/vim-markdown)
* [vim-pathogen](https://github.com/tpope/vim-pathogen)

### Custom macOS defaults

Custom macOS settings can be applied during the `dotfiles` process. They can
also be applied independently by running the following command:

```bash
$ macosdefaults
```

### Custom bash prompt

I use a custom bash prompt based on the Solarized color palette and influenced
by @gf3's and @cowboy's custom prompts. For best results, you should install
iTerm2 and import [Solarized
Dark.itermcolors](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized).

When your current working directory is a Git repository, the prompt will
display the checked-out branch's name (and failing that, the commit SHA that
HEAD is pointing to). The state of the working tree is reflected in the
following way:

<table>
    <tr>
        <td><code>+</code></td>
        <td>Uncommitted changes in the index</td>
    </tr>
    <tr>
        <td><code>!</code></td>
        <td>Unstaged changes</td>
    </tr>
    <tr>
        <td><code>?</code></td>
        <td>Untracked files</td>
    </tr>
    <tr>
        <td><code>$</code></td>
        <td>Stashed files</td>
    </tr>
</table>

Further details are in the `shell/bash_prompt` file.

Screenshot:

![](http://i.imgur.com/DSJ1G.png)

### Local/private Bash and Vim configuration

Any special-case Vim directives local to a machine should be stored in a
`~/.vimrc.local` file on that machine. The directives will then be automatically
imported into your master `.vimrc`.

Any private and custom Bash commands and configuration should be placed in a
`~/.bash_profile.local` file. This file will not be under version control or
committed to a public repository. If `~/.bash_profile.local` exists, it will be
sourced for inclusion in `bash_profile`.

Here is an example `~/.bash_profile.local`:

```bash
# PATH exports
PATH=$PATH:~/.gem/ruby/1.8/bin
export PATH

# Git credentials
# Not under version control to prevent people from
# accidentally committing with your details
GIT_AUTHOR_NAME="Chris O'Donnell"
GIT_AUTHOR_EMAIL="chris@example.com"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
# Set the credentials (modifies ~/.gitconfig)
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Aliases
alias code="cd ~/Sites"
```

N.B. Because the `git/gitconfig` file is copied to `~/.gitconfig`, any private
git configuration specified in `~/.bash_profile.local` will not be committed to
your dotfiles repository.

### Custom location for Homebrew installation

If your Homebrew installation is not in `/usr/local` then you must prepend your
custom installation's `bin` to the PATH in a file called `~/.dotfilesrc`:

```bash
# Add `brew` command's custom location to PATH
PATH="/opt/acme/bin:$PATH"
```


## Adding new git submodules

If you want to add more git submodules, e.g., Vim plugins to be managed by
pathogen, then follow these steps while in the root of the superproject.

```bash
# Add the new submodule
git submodule add https://example.com/remote/path/to/repo.git vim/bundle/one-submodule
# Initialize and clone the submodule
git submodule update --init
# Stage the changes
git add vim/bundle/one-submodule
# Commit the changes
git commit -m "Add a new submodule: one-submodule"
```


## Updating git submodules

Updating individual submodules within the superproject:

```bash
# Change to the submodule directory
cd vim/bundle/one-submodule
# Checkout the desired branch (of the submodule)
git checkout master
# Pull from the tip of master (of the submodule - could be any sha or pointer)
git pull origin master
# Go back to main dotfiles repo root
cd ../../..
# Stage the submodule changes
git add vim/bundle/one-submodule
# Commit the submodule changes
git commit -m "Update submodule 'one-submodule' to the latest version"
# Push to a remote repository
git push origin master
```

Now, if anyone updates their local repository from the remote repository, then
using `git submodule update` will update the submodules (that have been
initialized) in their local repository. N.B This will wipe away any local
changes made to those submodules.


## Acknowledgements

Inspiration and code was taken from many sources, including:

* [@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens)
  [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [@tejr](https://github.com/tejr) (Tom Ryder)
  [https://github.com/tejr/dotfiles](https://github.com/tejr/dotfiles)
* [@gf3](https://github.com/gf3) (Gianni Chiappetta)
  [https://github.com/gf3/dotfiles](https://github.com/gf3/dotfiles)
* [@cowboy](https://github.com/cowboy) (Ben Alman)
  [https://github.com/cowboy/dotfiles](https://github.com/cowboy/dotfiles)
* [@alrra](https://github.com/alrra) (Cãtãlin Mariş)
  [https://github.com/alrra/dotfiles](https://github.com/alrra/dotfiles)

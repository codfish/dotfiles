# Allow aliases to be with sudo
alias sudo="sudo "

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias -- -="cd -"
alias home="cd ~"

# List dir contents aliases
# ref: http://ss64.com/osx/ls.html
# Long form no user group, color
alias l="ls -oG"
# Order by last modified, long form no user group, color
alias lt="ls -toG"
# List all including . & .., color, mark file types, long form no user group, file size
alias ll="ls -aGlFh"
# List all except . and ..., color, mark file types, long form no use group, order by last modified, file size
alias lat="ls -AGlFoth"

# Concatenate and print content of files (add line numbers)
alias catn="cat -n"

# Open file in existing MacVim window
alias gvim="open -a MacVim"
alias mvim="open -a MacVim"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# Copy my public key to the pasteboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"

# Flush DNS cache
alias flushdns="dscacheutil -flushcache"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias showdeskicons="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias hidedeskicons="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper (Renderer) --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# open chromes
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chromium="/Applications/Chromium.app/Contents/MacOS/Chromium"

# open Chrome in "safe mode"
alias ogc='open -a Google\ Chrome --args --disable-extensions'

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update="sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; npm update npm -g; npm update -g; sudo gem update"

# open dotfiles for edits
alias editdot='cd ~/.dotfiles; code ~/.dotfiles'
alias editdotfiles='editdot'
alias codedot='editdot'
alias codedotfiles='editdot'

# edit your profile and reload it easily
alias rc='vim ~/.zshrc; source ~/.zshrc'
alias localrc='vim ~/.zshrc.local; source ~/.zshrc'

# typos
alias gits='git s'

# git remove merged branches
alias gremovemerged='git branch --merged | grep -v "\*" | grep -v main | grep -v dev | xargs -n 1 git branch -d'

# docker things
alias docker-compose='docker compose'

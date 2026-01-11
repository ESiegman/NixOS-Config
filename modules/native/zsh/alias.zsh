# modules/native/zsh/alias.zsh

alias ls='eza --tree --level=2 --icons --group-directories-first --git-ignore --long --no-permissions --no-user --no-time'
alias ll='eza --tree --level=4 --icons --group-directories-first --git-ignore' 
alias l='eza -lah --icons --group-directories-first' 
alias -- cat='bat'
alias -- grep='grep --color=auto'

alias -- ..='cd ..'
alias -- ...='cd ../..'
alias q='exit'
alias nconf='cd ~/NixOS-Config'

alias -- ff='fastfetch --logo ~/NixOS-Config/modules/assets/images/fastfetch.png --logo-height 21'
alias mkdir='mkdir -p'
alias cps="cp -iv"
alias mvs="mv -iv"
alias rms="rm -iv"

alias nlog='nix store diff-closures /run/current-system "$(ls -d /nix/var/nix/profiles/system-*-link | tail -n 2 | head -n 1)'
alias ncg='sudo nix-collect-garbage -d' 
alias nclean='sudo nix-collect-garbage --delete-older-than 7d; nix-store --optimise'

export MANPAGER="sh -c 'col -bx | bat -l man -p'"



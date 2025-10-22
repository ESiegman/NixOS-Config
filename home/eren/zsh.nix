# home/eren/zsh.nix
{ config, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    autocd = true;

    shellAliases = {
      ls = "ls --color=auto";
      cat = "bat";
      grep = "grep --color=auto";
      ".." = "cd ..";
      "..." = "cd ../..";
      l = "ls -lah";
      ll = "ls -l";
      zed = "zeditor";

      buildsys = "sudo nixos-rebuild switch --flake .#desktop";
      fastfetch = "fastfetch --logo /etc/nixos/images/fastfetch.png --logo-height 21";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      share = true;
      ignoreDups = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
    };

    initContent = ''
      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down

      function virt_env {
        if [[ -n "$VIRTUAL_ENV" ]]; then
          deactivate
        else
          if [ ! -d "./venv" ]; then
            python -m venv venv
          fi
          source ./venv/bin/activate
        fi
      }

      function nix-switch {
        local config_dir="$HOME/NixOS-Config"
        local system_config_path="/etc/nixos/configuration.nix"
        
        if [ ! -d "$config_dir" ]; then
            echo "Error: Configuration directory '$config_dir' not found."
            return 1
        fi
        
        cd "$config_dir" || return 1
        if ! git diff --quiet HEAD; then
            echo "Error: You have uncommitted changes in $config_dir."
            echo "Please commit or stash them before switching."
            return 1
        fi
        
        if [ ! -L "$system_config_path" ] || [ "$(readlink "$system_config_path")" != "$config_dir/configuration.nix" ]; then
            echo "Linking configuration.nix to $config_dir/configuration.nix"
            sudo ln -sf "$config_dir/configuration.nix" "$system_config_path"
        fi
        
        echo "Starting NixOS rebuild and switch..."
        sudo nixos-rebuild switch --flake "$config_dir#$USER"
        
        local status=$?
        
        if [ $status -eq 0 ]; then
            echo "NixOS switch successful."
            git add .
            git commit -m "System rebuild successful (Automated switch on $(date +%F %T))"
            git push
            echo "Changes pushed to GitHub."
        else
            echo "NixOS switch FAILED. No changes were committed or pushed."
        fi
        
        return $status
      }

      fastfetch --logo /etc/nixos/images/fastfetch.png --logo-height 25
    '';
  };
}

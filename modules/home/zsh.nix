# modules/home/zsh.nix
{ config, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    autocd = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      share = true;
      ignoreDups = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };

    initContent = ''
      source ${../../modules/native/zsh/var.zsh}
      source ${../../modules/native/zsh/alias.zsh}
      source ${../../modules/native/zsh/bindings.zsh}
      source ${../../modules/native/zsh/functions.zsh}
      source ${../../modules/native/zsh/startup.zsh}
    '';
  };
}

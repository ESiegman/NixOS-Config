# home/eren/vesktop.nix
{...}: {
  programs.vesktop = {
    enable = true;
    vencord = {
      settings = {
        plugins = {
          MessageLogger.enabled = true;
          AlwaysAnimate.enabled = true;
          ClearURLs.enabled = true;
          FixCodeblockGap = true;
          ForceOwnerCrown = true;
          FriendsSince = true;
          FullSearchContext = true;
          ImageFilename = true;
          ImplicitRelationships = true;
          MemberCount = true;
          MessageClickActions = true;
          oneko = true;
          petpet = true;
          ReadAllNotificationsButton = true;
          ServerInfo = true;
          ShikiCodeblocks = true;
          ShowHiddenChannels = true;
          SilentTyping = true;
        };
        enabledThemes = ["Main"];
      };
      themes = {
        Main = builtins.readFile ./../native/vesktop/theme.css;
      };
    };
  };
}

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
          FixCodeblockGap.enabled = true;
          ForceOwnerCrow.enabledn = true;
          FriendsSince.enabled = true;
          FullSearchContext.enabled = true;
          ImageFilename.enabled = true;
          ImplicitRelationships.enabled = true;
          MemberCount.enabled = true;
          MessageClickActions.enabled = true;
          oneko.enabled = true;
          petpet.enabled = true;
          ReadAllNotificationsButton.enabled = true;
          ServerInfo.enabled = true;
          ShikiCodeblocks.enabled = true;
          ShowHiddenChannels.enabled = true;
          SilentTyping.enabled = true;
          QuickReply.enabled = true;
        };
        enabledThemes = ["Main.css"];
      };
      themes = {
        "Main" = builtins.readFile ./../native/vesktop/theme.css;
      };
    };
  };
}

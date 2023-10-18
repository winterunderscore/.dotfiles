{pkgs, ...}: {
  programs = {
    eza = {
      enable = true;
      enableAliases = true;
      extraOptions = [
        "-a"
      ];
    };
    git = {
      enable = true;
    };
  };
}

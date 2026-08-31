{lib, ...}: {
  imports = [
    ./git.nix
    ./hunk.nix
    ./nixvim
    ./pi.nix
  ];

  options.my.development = {
    enable = lib.mkEnableOption "opinionated software development environment";

    git = {
      email = lib.mkOption {
        type = lib.types.str;
        description = "Email address used for Git commits.";
      };
      name = lib.mkOption {
        type = lib.types.str;
        description = "Name used for Git commits.";
      };
    };
  };
}

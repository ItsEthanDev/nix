{
  config,
  inputs,
  pkgs,
  ...
}: let
  colors = config.lib.stylix.colors;
  mandelbrust = inputs.mandelbrust.packages.${pkgs.stdenv.hostPlatform.system}.default;
  wallpaper = pkgs.runCommand "mandelbrust-spirals-wallpaper.png" {} ''
    ${mandelbrust}/bin/mandelbrust render \
      --preset spirals \
      --size 3840x2160 \
      --outside-color ${colors.base05} \
      --inside-color ${colors.base01} \
      --output "$out" \
      --quiet
  '';
in {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
    inputs.stylix.nixosModules.stylix
  ];

  programs.noctalia-greeter = {
    enable = true;
    settings = {
      session.default = "Hyprland (uwsm-managed)";
      appearance = {
        scheme = "Synced";
        hide_logo = false;
        theme_mode =
          if config.stylix.polarity == "light"
          then "light"
          else "dark";
        font_family = config.stylix.fonts.sansSerif.name;
        palette = with colors.withHashtag; {
          primary = base0D;
          on_primary = base00;
          secondary = base0E;
          on_secondary = base00;
          tertiary = base0C;
          on_tertiary = base00;
          error = base08;
          on_error = base00;
          surface = base00;
          on_surface = base05;
          surface_variant = base01;
          on_surface_variant = base04;
          outline = base03;
          shadow = base00;
          hover = base0C;
          on_hover = base00;
        };
        wallpaper = {
          path = "${wallpaper}";
          fill_mode = "crop";
        };
      };
    };
  };

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/espresso.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sizes.terminal = 16;
    };
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
    image = wallpaper;
  };
}

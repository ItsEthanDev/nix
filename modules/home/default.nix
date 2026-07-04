{
  cli = import ./cli;
  development = import ./development;
  desktop = import ./desktop;
  gaming = import ./gaming;
  media = import ./media;
  remote = import ./remote;
  terminal = import ./terminal;

  default = {
    imports = [
      ./cli
      ./development
      ./desktop
      ./gaming
      ./media
      ./remote
      ./terminal
    ];
  };
}

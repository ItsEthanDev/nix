{
  cli = import ./cli;
  development = import ./development;
  desktop = import ./desktop;
  gaming = import ./gaming;
  remote = import ./remote;
  terminal = import ./terminal;

  default = {
    imports = [
      ./cli
      ./development
      ./desktop
      ./gaming
      ./remote
      ./terminal
    ];
  };
}

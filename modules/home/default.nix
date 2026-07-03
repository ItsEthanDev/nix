{
  applications = import ./applications;
  desktop = import ./desktop;
  shell = import ./shell;

  default = {
    imports = [
      ./applications
      ./desktop
      ./shell
    ];
  };
}

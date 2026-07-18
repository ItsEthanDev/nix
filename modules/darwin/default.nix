{
  aerospace = import ./aerospace;
  fish = import ./fish;
  homebrew = import ./homebrew;

  default = {
    imports = [
      ./aerospace
      ./fish
      ./homebrew
    ];
  };
}

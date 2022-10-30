{ pkgs, ... }@args_:

let
  args = args_ // (import ./shared.nix args_);
in
{
  imports = [
    (import ../home-manager/work-config.nix args)
  ];
}

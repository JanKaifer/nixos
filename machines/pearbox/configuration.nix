{ pkgs, config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # We need few volumes to be mounted before our system starts booting
  fileSystems."/var/log".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/".neededForBoot = true;
  fileSystems."/home".neededForBoot = true;

  # Host name
  networking.hostName = "pearbox";

  # Wallpaper
  home-manager.users.pearman.dconf.settings."org/gnome/desktop/background".picture-uri = "file://" + ../../wallpapers/space.jpg;

  # Install nvidia drivers
  # services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.videoDrivers = [ "nouveau" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # Use unstable for new nvidia drivers
  nix.nixPath = lib.mkForce
    (
      let
        nixosRepoPath = "/persist/home/pearman/dev/jankaifer/nixos";
      in
      [
        "nixpkgs=${nixosRepoPath}/modules/nixpkgs-unstable"
        "nixos-config=${nixosRepoPath}/machines/${config.networking.hostName}/configuration.nix"
      ]
    );

  # Options
  custom = {
    erase-root.enable = true;
    fck.enable = true;
    games.enable = true;
    gui.enable = true;
    real-vnc-viewer.enable = true;
    vscode.enable = true;
    zsa.enable = true;
  };
}

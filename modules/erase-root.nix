{ config, lib, pkgs, ... }:

{
  options.custom.erase-root =
    {
      enable = lib.mkOption {
        default = false;
        example = true;
        description = ''
          Whether to erase root on boot.
        '';
      };
    };

  config = lib.mkIf config.custom.erase-root.enable
    {
      environment.persistence."/persist" = {
        hideMounts = true;
        directories = [
          "/etc/NetworkManager/system-connections"
          "/var/lib/bluetooth"
          "/var/lib/docker"
          "/var/lib/flatpak"
          "/var/lib/fprint"
          "/var/lib/systemd/coredump"
        ];
        files = [
          "/etc/machine-id"
        ];

        users.pearman = {
          directories = [
            "Documents"
            "Downloads"
            "Pictures"
            "Projects"
            "dev"

            ".ssh"

            ".cache"
            ".config/Bitwarden"
            ".config/BraveSoftware"
            ".config/Code"
            ".config/Signal"
            ".config/Slack"
            ".config/discord"
            ".config/spotify"
            ".local/share/Steam"
            ".local/share/direnv"
            ".local/share/flatpak"
            ".zoom"
          ];

          files = [
            ".zsh_history"
            ".bash_history"
            ".config/monitors.xml"
          ];
        };
      };

      programs.fuse.userAllowOther = true;

      home-manager.users.pearman = {
        imports = [ ./impermanence/home-manager.nix ];

        # Files that we want to trach in git
        home.persistence."/etc/nixos/modules/dotfiles/" = {
          removePrefixDirectory = true;
          allowOther = true;
          directories = [
          ];

          files = [ ];
        };
      };
    };
}

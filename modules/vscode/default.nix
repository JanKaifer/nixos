{ config, lib, pkgs, ... }:

{
  options.custom.vscode =
    {
      enable = lib.mkOption {
        default = false;
        example = true;
        description = ''
          Install vscode with my config.
        '';
      };
    };

  config = lib.mkIf config.custom.vscode.enable {
    home-manager.users.pearman.programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhsWithPackages (
        ps: with ps; [
          # General
          git

          # Nix
          nil
          nixpkgs-fmt

          # Rust
          rustup
          zlib

          # JS
          nodejs-16_x
          nodePackages.pnpm
        ]
      );
      extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./extensions.nix).extensions;
      userSettings = {
        "editor.minimap.enabled" = false;
        "git.enableSmartCommit" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
        # Nil is broken in my setup :sad:
        # "nix.enableLanguageServer" = true;
        # "nix.serverPath" = "nil";
        "editor.formatOnSave" = true;
        "window.zoomLevel" = 0;
        "keyboard.dispatch" = "keyCode";
        "vim.vimrc.enable" = true;
        "vim.vimrc.path" = "/home/pearman/.vimrc";
        "vim.useSystemClipboard" = true;
        "workbench.startupEditor" = "none";
        "update.mode" = "none";
        "editor.renderWhitespace" = "all";
        "projectManager.showParentFolderInfoOnDuplicates" = true;
        "projectManager.git.baseFolders" = [
          "/home/pearman/Projects"
          "/home/pearman/dev"
        ];
        "projectManager.git.maxDepthRecursion" = 2;
      };
    };
  };
}

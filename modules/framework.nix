{ pkgs, lib, ... }:

{
  options.custom.framework =
    {
      enable = lib.mkOption {
        default = false;
        example = true;
        description = ''
          Whether to enable fixes for Framework.
        '';
      };
    };

  config = {
    # Enable fingerprint
    services.fprintd.enable = true;

    # Fixes from https://dov.dev/blog/nixos-on-the-framework-12th-gen

    ## Fix brightness keys
    boot.kernelParams = [ "module_blacklist=hid_sensor_hub" ];
  };
}

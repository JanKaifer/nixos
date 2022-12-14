# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/6a24e7e8-8471-436f-952c-236e537be8b9";

  fileSystems."/" =
    {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=755" ];
    };

  fileSystems."/tmp" =
    {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" ];
    };

  fileSystems."/home" =
    {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=777" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/7941-42AE";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/784a8f38-ee55-4b47-abe2-6d4847442e5f";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/persist" =
    {
      device = "/dev/disk/by-uuid/784a8f38-ee55-4b47-abe2-6d4847442e5f";
      fsType = "btrfs";
      options = [ "subvol=persist" ];
    };

  fileSystems."/var/log" =
    {
      device = "/dev/disk/by-uuid/784a8f38-ee55-4b47-abe2-6d4847442e5f";
      fsType = "btrfs";
      options = [ "subvol=log" ];
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/549201d4-dd64-47fc-af03-031d158b4279"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp166s0.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{ config, lib, pkgs, modulesPath, ...}:
{
  imports = [];
  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ahci" "sd_mod" "sr_mod"];
      kernelModules = [];
    };
    kernelModules = [];
    extraModulePackages = [];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
      };
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d143861b-11c8-4282-b01d-acba013f83c0";
    fsType = "ext4";
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      #powerManagement.enable = false; # saves the VRAM completely on sleep
      open = false; # don't use the open source driver
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}

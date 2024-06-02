# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{
  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ahci" "sd_mod" "sr_mod"];
      kernelModules = [];
    };
    kernelModules = [];
    extraModulePackages = [];

    loader = {
      systemd-boot.enable = true;
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

  networking.useDHCP = true;
  nixpkgs.hostPlatform = "x86_64-linux";
}

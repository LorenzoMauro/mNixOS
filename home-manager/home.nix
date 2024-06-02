# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "lorenzo";
    homeDirectory = "/home/lorenzo";
  };


  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";

# Enable Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      syntax on
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set autoindent
    '';
  };

  # Enable i3 window manager
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ i3status dmenu ];
      config = {
        keybindings = {
          # Add your keybindings here
        };
        statusCommand = "${pkgs.i3status}/bin/i3status";
      };
    };
    displayManager.gdm.enable = true;
  };

  # Set the desktop background
  xsession.windowManager.i3.extraSessionCommands = ''
    feh --bg-scale /home/lorenzo/mNixOS/home-manager/yutian-li-render-image-a5.jpeg
  '';

  # Add packages
  home.packages = with pkgs; [
    git
    gnumake
    neovim
    i3
    i3status
    dmenu
    feh
  ];
}

# 
# sik: this is a good reference https://gist.github.com/domenkozar/9071879
#
#
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nekyia"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  #
  #  (pkgs.texLiveAggregationFun { paths = [ pkgs.texLive pkgs.texLiveExtra pkgs.texLiveBeamer ]; })
  environment.systemPackages = with pkgs; [
     wget
     git
     htop
     curl
     vim
     firefox
     emacs
     xlibs.xmessage
     xfce.terminal

    # python stuff
    python27Full
    python33
    pythonPackages.virtualenv
    pythonPackages.flake8
    pythonPackages.bpython
   ];

  nixpkgs.config.allowUnfree = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  #services.xserver = { displayManager.slim.autoLogin = true;
  #                     displayManager.slim.defaultUser = "timsears";
  #                     windowManager.xfce.enable = true;
  #                     windowManager.default = "xfce";
  #                     # only seem to affect login screen
  #                     virtualScreen = { x = 1920; y = 1200; };
  #                     resolutions = [{ x = 1920; y = 1200; }] ;
  #                     enable = true;
  #                     layout = "us";
  #                      };
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xterm.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.sik = {
    isNormalUser = true;
    name = "sik";
    group = "users";
    extraGroups = ["wheel" "networkmanager" ];
    uid = 1000;
    createHome = true;
    home = "/home/sik";
    shell = "/run/current-system/sw/bin/bash";
   };


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

  # Have the nixos manual handy ctrl+alt+F8 to access
  services.nixosManual.showManual = true;

}

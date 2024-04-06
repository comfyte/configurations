{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 0;
  };

  networking = {
    hostName = "mfr-dell-nixos";
    networkmanager.enable = true;

    firewall = {
      allowedTCPPorts = [
        # RDP port
        3389

        # UxPlay ports
        7000
        7001
        7100
      ];
      allowedUDPPorts = [
        # UxPlay ports
        5353
        6000
        6001
        7011
      ];
    };
  };

  time.timeZone = "Asia/Jakarta";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "id_ID.UTF-8";
      LC_IDENTIFICATION = "id_ID.UTF-8";
      LC_MEASUREMENT = "id_ID.UTF-8";
      LC_MONETARY = "id_ID.UTF-8";
      LC_NAME = "id_ID.UTF-8";
      LC_NUMERIC = "id_ID.UTF-8";
      LC_PAPER = "id_ID.UTF-8";
      LC_TELEPHONE = "id_ID.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "us";
      xkbVariant = "";
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # For uxplay
    avahi = {
      enable = true;

      publish = {
        enable = true;
        userServices = true;
      };
    };
  };

  sound.enable = true;

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  users.users.comfyte = {
    isNormalUser = true;
    description = "Farrel R";
    extraGroups = [ "networkmanager" "wheel" ];

    packages = with pkgs; [
      firefox
      google-chrome
      spotify
      vscode
      neofetch
      transmission
      yt-dlp
      obs-studio
      zoom-us
      vlc
      uxplay
      bottles
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      git
      cinnamon.nemo
    ];

    gnome.excludePackages = with pkgs.gnome; [ nautilus ];
  };

  # It is recommended to not change this line
  system.stateVersion = "23.11";

  # Waydroid
  virtualisation.waydroid.enable = true;

  programs.mtr.enable = true;
}

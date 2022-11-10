{ config, lib, machine, ... }:
with machine; {
  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    interfaces.wlp170s0.useDHCP = true;
  };

  virtualisation.docker.enable = true;

  time.timeZone = timezone;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  services = import ./services { inherit pkgs; };

  users.users = let keys-path = ./../../common/keys;
  in {
    ${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
      home = "/home/" + username;
      description = user-fullname;
      shell = pkgs.fish;
      openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
    };
    root = {
      openssh.authorizedKeys.keyFiles = [ "${keys-path}/authorized_keys" ];
      shell = pkgs.fish;
    };
  };

  environment.variables = {
    EDITOR = "emacs";
    VISUAL = "emacs";
  };
  # nixpkgs.config = config;

  programs = {
    # steam.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

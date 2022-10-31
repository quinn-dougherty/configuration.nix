{ config, lib, pkgs, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    # };
    settings.auto-optimise-store = true;
  };

}

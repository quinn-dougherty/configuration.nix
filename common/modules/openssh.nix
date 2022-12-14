{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };
}

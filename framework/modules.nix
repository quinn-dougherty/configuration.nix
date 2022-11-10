{ framework, nixos-hardware, home-manager, sops-nix, nix-doom-emacs }:

[
  (import ./system/configuration.nix { inherit framework; })
  ./system/hardware-configuration.nix
  ./../common/cachix.nix
  nixos-hardware.nixosModules.framework
  home-manager.nixosModules.home-manager
  sops-nix.nixosModules.sops
  {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users = {
        ${framework.username} =
          import ./users/qd/home.nix { inherit framework nix-doom-emacs; };
        # extraSpecialArgs.daedalus = daedalus;  # Passes more arguments to home.nix
        root = import ./users/root/home.nix { inherit framework; };
      };
    };
  }
]

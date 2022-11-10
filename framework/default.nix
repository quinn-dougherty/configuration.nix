{ lib, framework, nixos-hardware, agenix, home-manager, nix-doom-emacs }:
framework // {
  operatingsystem = lib.nixosSystem {
    system = framework.system;
    modules = import ./modules {
      inherit framework nixos-hardware agenix home-manager nix-doom-emacs;
    };
    specialArgs = { machine = framework; };
  };
  homeshell = with framework;
    pkgs.mkShell {
      name = "${drv-name-prefix}:home-shell";
      buildInputs = import ./users/qd/packages/development {
        inherit pkgs pkgs-stable agenix;
      };
    };
}

{ machine, nix-doom-emacs, agenix }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${machine.username} = import ./../users/qd/home.nix {
        inherit nix-doom-emacs;
        framework = machine;
      };
      root = import ./../users/root/home.nix {
        inherit agenix;
        framework = machine;
      };
    };
    # extraSpecialArgs.daedalus = daedalus;  # Passes more arguments to home.nix
  };
}

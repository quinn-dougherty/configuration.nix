{
  description = "quinnd's NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-22.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hercules-ci-agent = {
      url = "github:hercules-ci/hercules-ci-agent";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    python-on-nix = {
      url = "github:on-nix/python";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # daedalus.url = github:input-output-hk/daedalus/chore/ddw-1083-flakes;
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, sops-nix
    , home-manager, nix-doom-emacs, hercules-ci-agent, hercules-ci-effects
    , python-on-nix, ... }:
    let
      machines = fromTOML (builtins.readFile ./machines.toml);
      common = machines.common // {
        pkgs = import nixpkgs { system = machines.system; };
      };
      framework = rec {
        hostname = machines.framework.hostname;
        username = machines.framework.username;
        system = machines.common.system;
        timezone = machines.common.timezone;
        drv-name-prefix = "${username}@${hostname}:";
        overlays = let
          factorioOverlay = final: prev: {
            factorio = prev.factorio.override {
              username = "quinnd";
              token = "\${FACTORIO_KEY}";
            };
          };
          pythonOnNixOverlay = final: prev: {
            python-on-nix = python-on-nix.lib.${system};
          };
        in [ factorioOverlay pythonOnNixOverlay ];
        config.allowUnfree = true;
        pkgs = import nixpkgs { inherit system overlays config; };
        pkgs-stable = import nixpkgs-stable { inherit system overlays config; };
      };
      agent = rec {
        hostname = machines.agent.hostname;
        username = machines.agent.username;
        system = machines.common.system;
        timezone = machines.common.timezone;
        overlays = [ hercules-ci-effects.overlay ];
        pkgs = import nixpkgs-stable { inherit system overlays; };
      };

    in rec {
      nixosConfigurations = {
        "${framework.hostname}" = nixpkgs.lib.nixosSystem {
          system = framework.system;
          modules = import ./framework/modules.nix {
            pkgs = framework.pkgs;
            inherit framework nixos-hardware sops-nix home-manager
              nix-doom-emacs hercules-ci-agent;
          };
        };
        # "${agent.hostname}" = nixpkgs.lib.nixosSystem {
        #   system = agent.system;
        #   modules =
        #     [ (import ./agent/network.nix { inherit hercules-ci-agent; }) ];
        # };
      };

      devShells.${framework.system}.home-development = framework.pkgs.mkShell {
        name = "${framework.drv-name-prefix}:development-home";
        buildInputs = import ./framework/users/qd/packages/development {
          pkgs = framework.pkgs;
          pkgs-stable = framework.pkgs-stable;
        };
      };

      checks.${machines.common.system}.lint =
        framework.pkgs.stdenv.mkDerivation {
          name = "dotfiles-lint";
          src = ./.;
          buildInputs = with framework.pkgs; [ nixfmt nodePackages.prettier ];
          buildPhase = ''
            for nixfile in $(find $src -type f | grep '[.]nix')
            do
              nixfmt --check $nixfile
            done
            prettier --check $src
          '';
          installPhase = "mkdir -p $out";
        };

      herculesCI.onPush = {
        "${framework.hostname}-home-shell".outputs =
          self.devShells.${framework.system}.home-development;
        "${framework.hostname}-os".outputs =
          self.nixosConfigurations.${framework.hostname}.config.system.build.toplevel;
        dotfiles-lint.outputs = self.checks.${machines.common.system}.lint;
        agent-os.outputs.effects = import agent/effect.nix { inherit agent; };
        };
      };
}

{
  description = "quinnd's NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-22.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
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
    nixinate = {
      url = "github:matthewcroughan/nixinate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    python-on-nix = {
      url = "github:on-nix/python";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # daedalus.url = github:input-output-hk/daedalus/chore/ddw-1083-flakes;
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager
    , nix-doom-emacs, hercules-ci-agent, hercules-ci-effects, nixinate
    , python-on-nix, ... }:
    let
      machines = import ./common/machines.nix {
        inherit nixpkgs nixpkgs-stable python-on-nix hercules-ci-effects;
      };
      framework = import ./framework {
        inherit nixos-hardware home-manager nix-doom-emacs;
        lib = nixpkgs.lib;
        framework = machines.framework;
      };
      agent = import ./agent {
        inherit hercules-ci-agent;
        lib = nixpkgs.lib;
        agent = machines.agent;
      };
      commonlib = import ./common/lib {
        inherit machines;
        outputs = self;
        agentdeploy = agent.deploymenteffect;
      };
    in rec {
      apps = nixinate.nixinate.${machines.common.system} self;

      nixosConfigurations = commonlib.osForAll [ framework agent ];

      devShells.${machines.framework.system}.homeshell = framework.homeshell;

      checks.${machines.common.system}.lint = commonlib.lint;

      herculesCI = commonlib.herc;
    };
}

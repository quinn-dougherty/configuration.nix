{ lib, agent, hercules-ci-agent }:
agent // rec {
  operatingsystem = lib.nixosSystem {
    system = agent.system;
    modules = import ./modules.nix { inherit agent hercules-ci-agent; };
  };
  deploymenteffect-nixinate = { ref, nixination }:
    import ./effect/nixinate.nix { inherit ref agent nixination; };
  deploymenteffect = { ref }:
    import ./effect {
      inherit ref agent;
      agent-os = operatingsystem;
    };
}

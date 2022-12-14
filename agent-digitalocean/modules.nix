{ agent, hercules-ci-agent }:

[
  (import ./system/configuration.nix { inherit agent; })
  {
    _module.args.nixinate = {
      host = agent.ip;
      sshUser = agent.username;
      buildOn = "local"; # valid args are "local" or "remote"
      substituteOnTarget =
        true; # if buildOn is "local" then it will substitute on the target, "-s"
      hermetic = true;
    };
  }
  ./../common/modules/hercules.nix
  ./../common/modules/cachix
  ./../common/modules/nix.nix
  ./../common/modules/digitalocean.nix
  ./system/hardware-configuration.nix
  hercules-ci-agent.nixosModules.agent-service
  ./../common/modules/audit.nix
]

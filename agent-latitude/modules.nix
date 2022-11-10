{ agent, nixos-hardware, agenix, hercules-ci-agent }:

[
  (import ./system/configuration.nix { inherit agent; })
  {
    _module.args.nixinate = {
      host = agent.ip;
      sshUser = "root"; # agent.username;
      buildOn = "local"; # valid args are "local" or "remote"
      substituteOnTarget =
        true; # if buildOn is "local" then it will substitute on the target, "-s"
      hermetic = true;
    };
  }
  agenix.nixosModule
  nixos-hardware.nixosModules.dell-latitude-3340
  ./system/hardware-configuration.nix
  hercules-ci-agent.nixosModules.agent-service
  ./../common/modules/cachix
  ./../common/modules/audio.nix
  ./../common/modules/hercules.nix
  ./../common/modules/nix.nix
  ./../common/modules/gnome.nix
  ./../common/modules/audit.nix
  ./../common/modules/observability.nix
  ./../common/modules/utilities.nix
  ./../common/modules/age-secrets.nix
]

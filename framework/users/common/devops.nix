{ pkgs, agenix }:
with pkgs; [
  # nixops  # https://github.com/NixOS/nixops/issues/1521
  cachix
  # morph
  heroku
  hci
  age
  agenix.defaultPackage.${pkgs.system}
]

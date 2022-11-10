{ pkgs, pkgs-stable }:

let
  ops = import ./ops.nix { inherit pkgs pkgs-stable; };
  chat = import ./chat.nix { inherit pkgs; };
  # gaming = import ./gaming.nix { inherit pkgs; };
in builtins.concatLists [
  ops
  chat
  # gaming
  # [ daedalus ] # .outputs.${pkgs.system}.daedalus.packages.default ]
]

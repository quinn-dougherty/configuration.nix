{ pkgs }:

let
  utils = import ./utils.nix { inherit pkgs; };
  ops = import ./ops.nix { inherit pkgs; };
  chat = import ./chat.nix { inherit pkgs; };
  desktop = import ./x.nix { inherit pkgs; };
  gaming = import ./gaming.nix { inherit pkgs; };
in builtins.concatLists [
  utils
  ops
  chat
  desktop
  gaming
  # [ daedalus ] # .outputs.${pkgs.system}.daedalus.packages.default ]
]
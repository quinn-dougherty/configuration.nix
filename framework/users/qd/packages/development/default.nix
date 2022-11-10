{ pkgs, pkgs-stable, agenix }:
let
  devops = import ./../../../common/devops.nix { inherit pkgs agenix; };
  coq-development = import ./coq.nix { pkgs = pkgs-stable; };
  python-development = import ./python.nix { inherit pkgs; };
  rust-development = import ./rust.nix { pkgs = pkgs-stable; };
  javascript-development = import ./javascript.nix { inherit pkgs; };
  ocaml-development = import ./ocaml.nix { inherit pkgs; };
  haskell-development = import ./haskell.nix { inherit pkgs; };
  ruby-development = import ./ruby.nix { pkgs = pkgs-stable; };
in builtins.concatLists [
  devops
  coq-development
  python-development
  rust-development
  javascript-development
  ocaml-development
  haskell-development
  ruby-development
  [ pkgs.nixfmt ]
]

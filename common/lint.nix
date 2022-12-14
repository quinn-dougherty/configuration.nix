{ common }:
common.pkgs.stdenv.mkDerivation {
  name = "dotfiles-lint";
  src = ./../.;
  buildInputs = with common.pkgs; [ nixfmt nodePackages.prettier ];
  buildPhase = ''
    for nixfile in $(find $src -type f | grep '[.]nix')
    do
      nixfmt --check $nixfile
    done
    prettier --check $src
  '';
  installPhase = "mkdir -p $out";
}

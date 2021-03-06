{pkgs ? import ./pinnedNixpkgs.nix }:
let version = builtins.replaceStrings ["\n"] [""] (builtins.readFile ./version);
    python = (import ./requirements.nix { inherit pkgs; });
    py = python.packages;
in
python.mkDerivation {
  version = "${version}";
  name = "marge-${version}";
  src = ./.;
  buildInputs = [py.pytest py.pytest-cov py.pytest-pylint py.pytest-runner];
  propagatedBuildInputs = [py.ConfigArgParse py.maya py.PyYAML py.requests pkgs.openssh pkgs.git];
  meta = {
    homepage = "https://github.com/smarkets/marge-bot";
    description = "A build bot for gitlab";
    license = with pkgs.lib.licenses; [bsd3] ;
    maintainers =  [
      "Daniel Gorin <daniel.gorin@smarkets.com>"
      "Alexander Schmolck <alexander.schmolck@smarkets.com>"
    ];
    platforms = pkgs.lib.platforms.linux ++ pkgs.lib.platforms.darwin;
  };
 }

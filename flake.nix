{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [ 
              elixir
              erlang_26
              nodejs_22
              direnv
              inotify-tools
              just
            ];

            shellHook = ''
            eval "$(direnv hook bash)"
            direnv allow
            mix deps.get
            '';
          };
        }
      );
}

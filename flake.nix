{
  description = "BranchShell, an SSH client and BranchBay's terminal";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forEach = f: nixpkgs.lib.genAttrs systems (system: f system);

      # One file per channel, rewritten on every release: the version and,
      # per system, the file on the release host with its hash.
      channel = name: builtins.fromJSON (builtins.readFile (./nix + "/${name}.json"));

      package = system: release:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          lib = pkgs.lib;
          source = release.systems.${system} or (throw "BranchShell ${release.version} has no build for ${system}");
          runtimeLibraries = with pkgs; [ wayland vulkan-loader libxkbcommon xorg.libxcb xorg.libX11 dbus ];
        in
        pkgs.stdenv.mkDerivation {
          pname = "branchshell";
          inherit (release) version;
          src = pkgs.fetchurl { inherit (source) url hash; };

          nativeBuildInputs = lib.optionals pkgs.stdenv.isLinux [ pkgs.autoPatchelfHook pkgs.makeWrapper ]
            ++ lib.optionals pkgs.stdenv.isDarwin [ pkgs.unzip ];
          buildInputs = lib.optionals pkgs.stdenv.isLinux [ pkgs.dbus pkgs.libxkbcommon pkgs.xorg.libxcb pkgs.zlib pkgs.stdenv.cc.cc.lib ];

          # The zip holds the app bundle; unpacking it by hand keeps the
          # signature intact.
          unpackPhase = if pkgs.stdenv.isDarwin then "unzip -q $src" else null;
          sourceRoot = if pkgs.stdenv.isDarwin then "." else null;

          installPhase =
            if pkgs.stdenv.isDarwin then ''
              mkdir -p $out/Applications $out/bin
              cp -R BranchShell.app $out/Applications/
              ln -s $out/Applications/BranchShell.app/Contents/MacOS/branch-shell $out/bin/branch-shell
            '' else ''
              install -Dm755 branch-shell $out/bin/branch-shell
              install -Dm644 branchshell.desktop $out/share/applications/branchshell.desktop
              mkdir -p $out/share/icons
              cp -r icons/hicolor $out/share/icons/
              # Wayland and Vulkan are opened at run time rather than linked.
              wrapProgram $out/bin/branch-shell --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath runtimeLibraries}
            '';

          meta = {
            description = "SSH client and BranchBay's terminal";
            homepage = "https://branchbay.dev/branchshell";
            license = lib.licenses.unfree;
            platforms = systems;
            mainProgram = "branch-shell";
          };
        };
    in
    {
      packages = forEach (system:
        let
          stable = if builtins.pathExists ./nix/stable.json then { branchshell = package system (channel "stable"); } else { };
          beta = if builtins.pathExists ./nix/beta.json then { branchshell-beta = package system (channel "beta"); } else { };
          all = stable // beta;
        in
        all // { default = all.branchshell or all.branchshell-beta; });
    };
}

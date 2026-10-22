# BranchShell packages

Package definitions for [BranchShell](https://branchbay.dev/branchshell), the SSH
client that is BranchBay's terminal. The files themselves are on https://releases.branchbay.dev/branchshell; this
repository only tells each package manager where they are. Everything here
is rewritten by the release scripts, so edits belong there.

The default definitions follow the stable channel. Each has a beta variant
that follows the beta channel instead.

## Homebrew

```sh
brew tap branchshell/tap https://github.com/BranchBay/BranchShellTap.git
brew trust branchshell/tap
brew install --cask branchshell        # macOS
brew install branchshell               # Linux
```

Beta: `branchshell@beta` for the cask, `branchshell-beta` for the formula.

## Nix

```sh
nix run github:BranchBay/BranchShellTap
nix profile install github:BranchBay/BranchShellTap
```

Beta: add `#branchshell-beta`. In a NixOS or Home Manager configuration, add
this repository as a flake input and put
`inputs.branchshell.packages.${system}.branchshell` in your packages.

## Arch Linux

The `aur/` directory holds the `branchshell-bin` and `branchshell-beta-bin`
packages as published on the AUR:

```sh
git clone https://aur.archlinux.org/branchshell-bin.git
cd branchshell-bin && makepkg -si
```

## Gentoo

This repository is also an ebuild repository:

```sh
sudo eselect repository add branchshell git https://github.com/BranchBay/BranchShellTap.git
sudo emaint sync -r branchshell
echo 'dev-vcs/branchshell-bin all-rights-reserved' | sudo tee /etc/portage/package.license/branchshell
echo 'dev-vcs/branchshell-bin' | sudo tee /etc/portage/package.accept_keywords/branchshell
sudo emerge --ask dev-vcs/branchshell-bin
```

## Debian and Ubuntu

The APT repository lives on the release host, not here:

```sh
curl -fsSL https://releases.branchbay.dev/branchshell/apt/branchshell-archive-keyring.gpg | sudo tee /usr/share/keyrings/branchshell-archive-keyring.gpg >/dev/null
curl -fsSL https://releases.branchbay.dev/branchshell/apt/branchshell.sources | sudo tee /etc/apt/sources.list.d/branchshell.sources >/dev/null
sudo apt update && sudo apt install branchshell
```

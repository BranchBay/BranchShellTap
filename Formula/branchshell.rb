class Branchshell < Formula
  desc "SSH client and BranchBay's terminal"
  homepage "https://branchbay.dev/branchshell"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/branchshell/releases/1.0.5/branch-shell-1.0.5-linux-x86_64.tar.gz"
  version "1.0.5"
  sha256 "0c1361a50804a459a4658f2c165c9fa8b94185129b45d5c644434bd93ba1b91a"
  license :cannot_represent

  depends_on "dbus"
  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/branchshell/releases/1.0.5/branch-shell-1.0.5-linux-aarch64.tar.gz"
      sha256 "4b0f0c1a834ab9ce69098f5c095374d3d55c1a4e77a2ad394f1dcf286e6ded8a"
    end
  end

  def install
    # A prebuilt binary looks for its libraries on the system path, so the
    # launcher in bin points it at Homebrew's.
    libexec.install "branch-shell"
    (bin/"branch-shell").write_env_script libexec/"branch-shell", LD_LIBRARY_PATH: "#{HOMEBREW_PREFIX}/lib"
    (share/"applications").install "branchshell.desktop"
    (share/"icons").install "icons/hicolor"
  end

  test do
    assert_match "branch-shell", shell_output("#{bin}/branch-shell --version")
  end
end

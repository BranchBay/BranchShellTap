class Branchshell < Formula
  desc "SSH client and BranchBay's terminal"
  homepage "https://branchbay.dev/branchshell"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/branchshell/releases/1.0.0/branch-shell-1.0.0-linux-x86_64.tar.gz"
  version "1.0.0"
  sha256 "da0139bfda1362b55bd90a71a952362f451a58c4ae7f525df390c817c476a078"
  license :cannot_represent

  depends_on "dbus"
  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/branchshell/releases/1.0.0/branch-shell-1.0.0-linux-aarch64.tar.gz"
      sha256 "7ff7e9f24c0f25dc80edaf9be9575f55d1838f1e54a777105f0e6ea8d1562179"
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

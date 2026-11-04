class Branchshell < Formula
  desc "SSH client and BranchBay's terminal"
  homepage "https://branchbay.dev/branchshell"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/branchshell/releases/1.0.4/branch-shell-1.0.4-linux-x86_64.tar.gz"
  version "1.0.4"
  sha256 "6fc18ab94b0435f2f60f53418dd6b70c8e3b861ca84846dbc33a1fa6c8132e7c"
  license :cannot_represent

  depends_on "dbus"
  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/branchshell/releases/1.0.4/branch-shell-1.0.4-linux-aarch64.tar.gz"
      sha256 "b566088f6e47db93e504f3ad8326407baec3242d66cc4869f80c7bb88d4512c8"
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

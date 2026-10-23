class Branchshell < Formula
  desc "SSH client and BranchBay's terminal"
  homepage "https://branchbay.dev/branchshell"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/branchshell/releases/1.0.1/branch-shell-1.0.1-linux-x86_64.tar.gz"
  version "1.0.1"
  sha256 "876592630f6f6f39c22230fcb4b64edb31ad0dd758bac322466ea091fe2b320d"
  license :cannot_represent

  depends_on "dbus"
  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/branchshell/releases/1.0.1/branch-shell-1.0.1-linux-aarch64.tar.gz"
      sha256 "126882a14dcc3b88095d72cfcf1ba5eefc1ed75095917b7ae98b499143e6a105"
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

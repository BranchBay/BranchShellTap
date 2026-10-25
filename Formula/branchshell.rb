class Branchshell < Formula
  desc "SSH client and BranchBay's terminal"
  homepage "https://branchbay.dev/branchshell"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/branchshell/releases/1.0.2/branch-shell-1.0.2-linux-x86_64.tar.gz"
  version "1.0.2"
  sha256 "2ebfb5b9e8e1c6c9971f7d7351adf723c2d38b50fa89da512b42651adf4a5ddd"
  license :cannot_represent

  depends_on "dbus"
  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/branchshell/releases/1.0.2/branch-shell-1.0.2-linux-aarch64.tar.gz"
      sha256 "ba2a75206d301202451e9da3a01d4a7dc3b3464d74ee50ca357f1cf96ddef8d1"
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

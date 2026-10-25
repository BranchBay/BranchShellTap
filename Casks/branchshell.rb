cask "branchshell" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.2"
  sha256 arm:   "5a6fd90f20e6c62f0c68d94ab146b9deb57c4f14af16baf41833639a2c5d399a",
         intel: "1371f71c863fc924ac8137c3a4813cbc8ca5db138106e3bcd3af14ab7f4590f5"

  url "https://releases.branchbay.dev/branchshell/releases/#{version}/branch-shell-#{version}-macos-#{arch}.dmg"
  name "BranchShell"
  desc "SSH client and BranchBay's terminal"
  homepage "https://branchbay.dev/branchshell"

  livecheck do
    url "https://releases.branchbay.dev/branchshell/channels/stable.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on macos: :ventura

  app "BranchShell.app"
  binary "#{appdir}/BranchShell.app/Contents/MacOS/branch-shell", target: "branch-shell"

  zap trash: [
    "~/Library/Application Support/BranchShell",
    "~/Library/Preferences/dev.branchbay.shell.plist",
  ]
end

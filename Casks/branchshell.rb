cask "branchshell" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.6"
  sha256 arm:   "dcc7c5eb8956a1d051eb4865fb322c4510163c8ef54954b690ee4c45036e0b2e",
         intel: "2baf0a9308293c99d9dfcb5a296af937edc9d45e818834321bbd9a3b80ae4713"

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

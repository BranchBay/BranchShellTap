cask "branchshell" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.0"
  sha256 arm:   "151c8919c619e586f8ec4bfbb7e53fe69b53f438546b8aa76032007faed13dda",
         intel: "661117bb3a015b232f26dc50e464956531b7273ba39e687d5c993993974baa9f"

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

cask "branchshell" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.0"
  sha256 arm:   "7bba3ee0fdd7505e579e05615fc11a909bd8237a7b000e78ed64b6a1918c2e67",
         intel: "6af1205e178e5eaad1f2d38f44db7f9a9809ec3893857a9cb499e7143db43e37"

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

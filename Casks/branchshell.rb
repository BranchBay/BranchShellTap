cask "branchshell" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.1"
  sha256 arm:   "dd8eb3817df816ce98f91e28b93eb924e808ab162ff66ec60f6b342587910405",
         intel: "d9062679fd79c426e63802b9558633f966e5b1dfecd83e77556b6f2f3a1f0e90"

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

cask "branchshell" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.4"
  sha256 arm:   "950d8b701e260053410e0ae3c1391c4a514f6c955e094f9d3dddbbdff13ebe39",
         intel: "acc8aac4fe72a1d7ba855fa1c0202c28322c7c9cf64aaafee5ce8202b86fab31"

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

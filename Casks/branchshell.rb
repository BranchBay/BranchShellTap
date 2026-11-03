cask "branchshell" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.3"
  sha256 arm:   "4e8be8cd1ad3c65696f16f4288a885bcf4da26ba43a4b9d06bbf92ca96b5547d",
         intel: "d1e09526256bfbf5488cee93ce4a0d00c4a0fb67004fb432adf4aeb035ca7bfb"

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

cask "branchshell" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.0"
  sha256 arm:   "fd78bca759390a76ab665e7a4023c583c88f8ee0c2bc9f4865ecd3b34b78480b",
         intel: "f249ee111407785d7dbf968482ed626ff8ed4845b9fed131045075f22b8d3247"

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

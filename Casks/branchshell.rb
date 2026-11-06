cask "branchshell" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.5"
  sha256 arm:   "b57875ed45498e32486fd126fadbaf9a881b543d57d441aec3965bc6929e25d5",
         intel: "484ad544262f7d2b94107dde633fcc9804a27671c32fbc40360258224d444e19"

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

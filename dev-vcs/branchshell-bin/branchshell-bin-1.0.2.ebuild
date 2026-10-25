# Copyright 2026 TNT SOFT S.R.L.

EAPI=8

inherit desktop xdg

MY_PV="1.0.2"
DESCRIPTION="SSH client and BranchBay's terminal"
HOMEPAGE="https://branchbay.dev/branchshell"
SRC_URI="
	amd64? ( https://releases.branchbay.dev/branchshell/releases/${MY_PV}/branch-shell-${MY_PV}-linux-x86_64.tar.gz -> ${P}-x86_64.tar.gz )
	arm64? ( https://releases.branchbay.dev/branchshell/releases/${MY_PV}/branch-shell-${MY_PV}-linux-aarch64.tar.gz -> ${P}-aarch64.tar.gz )
"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-libs/wayland
	sys-apps/dbus
	media-libs/vulkan-loader
	sys-libs/zlib
	x11-libs/libxcb
	x11-libs/libxkbcommon[X]
"

QA_PREBUILT="usr/bin/branch-shell"

src_install() {
	cd "branch-shell-${MY_PV}-linux-$(usex amd64 x86_64 aarch64)" || die
	dobin branch-shell
	domenu branchshell.desktop
	local size
	for size in 32 48 128 256 512; do
		newicon -s "${size}" "icons/hicolor/${size}x${size}/apps/branchshell.png" branch-shell.png
	done
}

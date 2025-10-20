# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

EGIT_REPO_URI="https://github.com/LennardKittner/HyperHeadset.git"
EGIT_BRANCH="old_cloud2"
EGIT_SUBMODULES=( '*' )
EGIT_OVERRIDE_REPO_GIT_GITHUB_COM_RUABMBUA_HIDAPI_RS="https://github.com/ruabmbua/hidapi-rs.git"


DESCRIPTION="A CLI and tray application for monitoring and managing HyperX headsets."
HOMEPAGE="https://github.com/LennardKittner/HyperHeadset"
SRC_URI=""

KEYWORDS="~amd64"

LICENSE=""
# Dependent crate licenses
LICENSE+=" MIT Unicode-3.0 Unlicense"
SLOT="0"

RDEPEND="
	dev-libs/hidapi
	virtual/libudev
	virtual/libusb:1
"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	cargo_src_install

	insinto /usr/lib/udev/rules.d
	newins "${FILESDIR}/udev.rules" 99-HyperHeadset.rules
}

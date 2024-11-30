# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI=8

RUST_MIN_VER="1.82.0"

inherit cargo git-r3

DESCRIPTION="minimalistic menu for wayland (written in rust)"
HOMEPAGE="https://github.com/l4l/yofi"
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_BRANCH=master

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" BSD-2 BSD ISC MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Next generation command line interface for cilium"
HOMEPAGE="https://cilium.io"
SRC_URI="https://github.com/cilium/cilium-cli/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
BDEPENDS="
	>=dev-lang/go-1.21.6
	app-arch/unzip
"

src_prepare() {
	default
	sed -i -e 's/-race//' Makefile || die
}

src_compile() {
	emake VERSION=v${PV}
}

src_test() {
	emake test
}

src_install() {
	dobin cilium
}

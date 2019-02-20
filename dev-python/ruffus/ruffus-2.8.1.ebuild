# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Computation pipeline library"
HOMEPAGE="http://www.ruffus.org.uk/"

PYTHON_COMPAT=( python3_{4,5,6} )
inherit distutils-r1

SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


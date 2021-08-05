# Copyright 1999-2003 Gentoo Technologies, Inc.
# Written by Florian Huber <florian.huber@mnet-online.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Dummy kernel package to provide virtual/linux-sources"
KEYWORDS="~*"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"


IUSE=""
PROVIDE="virtual/linux-sources"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${P}"

src_install() {
	einfo "******************************************************************"
	einfo " ${P} installed..."
	einfo " This ebuild does nothing except"
	einfo " satisfying virtual/linux-sources dependencies"
	einfo "******************************************************************"
}

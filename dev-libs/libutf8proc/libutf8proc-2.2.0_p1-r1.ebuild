# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

MY_P="${P/_p/-}"
DESCRIPTION="mapping tool for UTF-8 strings"
HOMEPAGE="http://www.netsurf-browser.org/"
SRC_URI="https://download.netsurf-browser.org/libs/releases/${MY_P}-src.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

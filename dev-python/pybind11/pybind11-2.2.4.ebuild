# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="C++11 python bindings"
HOMEPAGE="https://github.com/pybind/pybind11"

PYTHON_COMPAT=( python3_{4,5,6} )
inherit distutils-r1

if [[ ${PV} == 9999* ]] ; then
    inherit git-r3
	EGIT_REPO_URI="https://github.com/pybind/pybind11.git"
else
	SRC_URI="https://github.com/pybind/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


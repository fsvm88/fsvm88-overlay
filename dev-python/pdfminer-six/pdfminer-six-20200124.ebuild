# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6,7} pypy )

inherit distutils-r1

DESCRIPTION="Python tool for extracting information from PDF documents"
HOMEPAGE="https://github.com/pdfminer/pdfminer.six/ https://pypi.org/project/pdfminer.six/"
SRC_URI="https://github.com/pdfminer/pdfminer.six/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples"

DEPEND="
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/pycryptodome[${PYTHON_USEDEP}]
		dev-python/sortedcontainers[${PYTHON_USEDEP}]
		dev-python/chardet[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${P/-six/.six}"

python_compile_all(){
	use examples && emake -C samples all
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/. )
	use examples && local EXAMPLES=( samples/. )
	distutils-r1_python_install_all
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )

inherit distutils-r1

DESCRIPTION="Python tool for reading and writing PDFs"
HOMEPAGE="https://github.com/pikepdf/pikepdf/ https://pypi.org/project/pikepdf/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples"

DEPEND="
		>=app-text/qpdf-8.4
		>=dev-python/defusedxml-0.5
		>=dev-python/lxml-4
"
BDEPEND="
		dev-python/pytest-runner
		dev-python/setuptools_scm
		dev-python/setuptools_scm_git_archive
		>=dev-python/pybind11-2.3.0
		<dev-python/pybind11-3
"

python_compile_all(){
	use examples && emake -C samples all
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/. )
	use examples && local EXAMPLES=( samples/. )
	distutils-r1_python_install_all
}

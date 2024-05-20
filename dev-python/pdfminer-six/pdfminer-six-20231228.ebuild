# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{1..2} pypy )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python tool for extracting information from PDF documents"
HOMEPAGE="https://github.com/pdfminer/pdfminer.six/ https://pypi.org/project/pdfminer.six/"
SRC_URI="https://github.com/pdfminer/pdfminer.six/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples image test"

DEPEND="
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx
		dev-python/sphinx-argparse
	)
	image? ( >=dev-python/pillow-10.3.0 )
	test? (
		dev-python/nox
		dev-python/pytest
	)
"

S="${WORKDIR}/${P/-six/.six}"

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

PATCHES=(
	"${FILESDIR}"/20231228-proper-versioning.patch
)

python_prepare_all() {
	distutils-r1_python_prepare_all
	sed -i -e 's:^version = "0.0":version = "'${PV}'":' setup.py
}

python_compile_all(){
	use examples && emake -C samples all
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/. )
	use examples && local EXAMPLES=( samples/. )
	distutils-r1_python_install_all
}

distutils_enable_tests pytest

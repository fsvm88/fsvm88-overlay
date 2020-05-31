# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Awesome tool to OCR and annotate PDFs using Tesseract"
HOMEPAGE="https://github.com/jbarlow83/OCRmyPDF"

if [[ ${PV} == 9999* ]] ; then
    inherit git-r3
	EGIT_REPO_URI="https://github.com/jbarlow83/OCRmyPDF.git"
else
	SRC_URI="https://github.com/jbarlow83/OCRmyPDF/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="test"

DEPEND="
		>=app-text/ghostscript-gpl-9.15
		>=app-text/qpdf-8.0.2
		>=app-text/tesseract-4.0.0
		>=app-text/unpaper-6.1
		=dev-python/chardet-3*[${PYTHON_USEDEP}]
		>=dev-python/cffi-1.9.1[${PYTHON_USEDEP}]
		>=dev-python/pdfminer-six-20181108[${PYTHON_USEDEP}]
		<=dev-python/pdfminer-six-20200402[${PYTHON_USEDEP}]
		=dev-python/pikepdf-1*[${PYTHON_USEDEP}]
		>=dev-python/pillow-6.2.0[${PYTHON_USEDEP}]
		>=dev-python/reportlab-3.3[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4[${PYTHON_USEDEP}]
		=media-gfx/img2pdf-0.3*
		>=media-gfx/pngquant-2.0.0
		media-libs/leptonica
		test? ( dev-python/pytest-runner )
		"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-python/cffi-1.9.1[${PYTHON_USEDEP}]"

python_prepare_all() {
	sed -i -e "/'pytest-runner'/d" setup.py || die
	distutils-r1_python_prepare_all
}

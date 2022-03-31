# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9,10} )
DISTUTILS_USE_SETUPTOOLS=rdepend

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
S="${WORKDIR}/OCRmyPDF-${PV}"

RDEPEND="
		<dev-python/pdfminer-six-20211012[${PYTHON_USEDEP}]
		<dev-python/pluggy-2[${PYTHON_USEDEP}]
		<media-gfx/img2pdf-0.5
		>=app-text/ghostscript-gpl-9.55.0-r1
		>=app-text/qpdf-10.3.2
		>=app-text/tesseract-4.1.1
		>=app-text/unpaper-6.1-r1
		>=dev-python/coloredlogs-14.0[${PYTHON_USEDEP}]
		>=dev-python/importlib_metadata-4[${PYTHON_USEDEP}]
		>=dev-python/pikepdf-4[${PYTHON_USEDEP}]
		>=dev-python/pillow-8.2.0[${PYTHON_USEDEP}]
		>=dev-python/pluggy-0.13[${PYTHON_USEDEP}]
		>=dev-python/reportlab-3.5.66[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.59[${PYTHON_USEDEP}]
		>=media-gfx/img2pdf-0.3
		>=media-gfx/pngquant-2.12.6
		>=media-libs/jbig2dec-0.19
		>dev-python/pdfminer-six-20200720[${PYTHON_USEDEP}]
		media-libs/icc-profiles-openicc
		sys-libs/zlib
		test? ( dev-python/pytest-runner )
		"
DEPEND="${RDEPEND}"

python_prepare_all() {
	sed -i -e "/'pytest-runner'/d" setup.py || die
	distutils-r1_python_prepare_all
}

# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )
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
		<dev-python/pikepdf-3[${PYTHON_USEDEP}]
		<dev-python/pluggy-1.0[${PYTHON_USEDEP}]
		=media-gfx/img2pdf-0.4*
		>=app-text/ghostscript-gpl-9.15
		>=app-text/qpdf-8.0.2
		>=app-text/tesseract-4.0.0
		>=app-text/unpaper-6.1
		>=dev-python/cffi-1.9.1[${PYTHON_USEDEP}]
		>=dev-python/coloredlogs-14.0[${PYTHON_USEDEP}]
		>=dev-python/pikepdf-2[${PYTHON_USEDEP}]
		>=dev-python/pillow-8.2.0[${PYTHON_USEDEP}]
		>=dev-python/pluggy-0.13[${PYTHON_USEDEP}]
		>=dev-python/reportlab-3.5[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.59[${PYTHON_USEDEP}]
		>=media-gfx/pngquant-2.0.0
		>=media-libs/leptonica-1.74.4
		>dev-python/pdfminer-six-20200720[${PYTHON_USEDEP}]
		dev-libs/libxml2
		media-libs/icc-profiles-openicc
		sys-libs/zlib
		test? ( dev-python/pytest-runner )
		"
DEPEND="${RDEPEND}"

python_prepare_all() {
	sed -i -e "/'pytest-runner'/d" setup.py || die
	distutils-r1_python_prepare_all
}

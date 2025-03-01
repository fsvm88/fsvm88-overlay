# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{1..3} )
DISTUTILS_USE_PEP517=hatchling

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
		>=app-text/ghostscript-gpl-10.02.0
		>=app-text/pdfminer-20220319[${PYTHON_USEDEP}]
		>=app-text/qpdf-11.5.0
		>=app-text/tesseract-5.3.0
		>=app-text/unpaper-7
		>=dev-python/coloredlogs-15.0.1-r1[${PYTHON_USEDEP}]
		>=dev-python/cython-3.0.2-r1[${PYTHON_USEDEP}]
		>=dev-python/deprecation-2.1.0-r1[${PYTHON_USEDEP}]
		>=dev-python/packaging-23.1[${PYTHON_USEDEP}]
		>=dev-python/pikepdf-8.10.1[${PYTHON_USEDEP}]
		>=dev-python/pillow-10.0.1[${PYTHON_USEDEP}]
		>=dev-python/pluggy-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/reportlab-4.0.4[${PYTHON_USEDEP}]
		>=dev-python/rich-13[${PYTHON_USEDEP}]
		>=dev-python/typing-extensions-4.7.1[${PYTHON_USEDEP}]
		>=media-gfx/img2pdf-0.5
		>=media-gfx/pngquant-2.17.0
		>=media-libs/jbig2dec-0.19
		media-libs/icc-profiles-openicc
		sys-libs/zlib
		test? (
			>=dev-python/coverage-6.2
			>=dev-python/hypothesis-6.36.0
			>=dev-python/pytest-6.2.5
			>=dev-python/pytest-cov-4.1.0
			>=dev-python/pytest-xdist-3.3.1
			>=dev-python/python-xmp-toolkit-2.0.1
		)
		"
DEPEND="${RDEPEND}"

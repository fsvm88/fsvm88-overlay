# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Awesome tool to OCR and annotate PDFs using Tesseract"
HOMEPAGE="https://github.com/jbarlow83/OCRmyPDF"

PYTHON_COMPAT=( python3_{4,5,6} )
inherit distutils-r1

if [[ ${PV} == 9999* ]] ; then
    inherit git-r3
	EGIT_REPO_URI="https://github.com/jbarlow83/OCRmyPDF.git"
else
	SRC_URI="https://github.com/jbarlow83/OCRmyPDF/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
		>=app-text/tesseract-4.0.0
		>=app-text/ghostscript-gpl-9.15
		>=app-text/unpaper-6.1
		>=app-text/qpdf-8.0.2
		>=media-gfx/pngquant-2.0.0
		=dev-python/chardet-3.0.4
		<dev-python/chardet-4
		>=dev-python/cffi-1.9.1
		>=media-gfx/img2pdf-0.3.0
		<media-gfx/img2pdf-0.4.0
		>=dev-python/pillow-4
		!=dev-python/pillow-5.1.0
		>=dev-python/reportlab-3.3
		=dev-python/pdfminer-six-20181108
		>=dev-python/pikepdf-1.3.0
		<dev-python/pikepdf-2
		>=dev-python/ruffus-2.7
		"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-python/cffi-1.9.1"

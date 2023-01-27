# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake eutils git-r3

DESCRIPTION="OpenGL and OpenCL test suite."
HOMEPAGE="http://piglit.freedesktop.org/"
SRC_URI=""
EGIT_REPO_URI="https://cgit.freedesktop.org/piglit
	https://anongit.freedesktop.org/git/piglit.git
	git://anongit.freedesktop.org/git/piglit"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="opencl test minimal"

RDEPEND="
	dev-python/mako
	dev-python/numpy
	dev-python/six
	media-libs/freeglut
	media-libs/waffle
	virtual/glu
	virtual/opengl
	!minimal? ( dev-python/lxml
		dev-python/simplejson )
	opencl? ( virtual/opencl )
	test? ( dev-python/mock
		dev-python/nose
		dev-python/tox )"

DEPEND="${RDEPEND}"

HDEPEND="dev-util/cmake"

#BUILD_DIR="${WORKDIR}/${P}"

src_configure() {
	local mycmakeargs=(
		-DPIGLIT_BUILD_CL_TESTS=$(usex opencl)
		-DPIGLIT_BUILD_DMA_BUF_TESTS=ON
		-DPIGLIT_BUILD_GLES1_TESTS=ON
		-DPIGLIT_BUILD_GLES2_TESTS=ON
		-DPIGLIT_BUILD_GLES3_TESTS=ON
		-DPIGLIT_BUILD_GLX_TESTS=ON
		-DPIGLIT_BUILD_GL_TESTS=ON
		-DPIGLIT_USE_WAFFLE=ON
	)
	cmake_src_configure
}

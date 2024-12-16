# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit cmake python-any-r1

DESCRIPTION="Library to coordinate the modification of intercept API tables for HSA/HIP/ROCTx runtime libraries"
HOMEPAGE="https://github.com/ROCm/rocprofiler-register"
SRC_URI="https://github.com/ROCm/${PN}/archive/rocm-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-rocm-${PV}"

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64"
IUSE="test"

PATCHES=(
	"${FILESDIR}/${PN}-6.3.0-cmake-fix-include-cpack.patch"
	"${FILESDIR}/${PN}-6.3.0-cmake-fix-lib-paths.patch"
	"${FILESDIR}/${PN}-6.3.0-tests-include-missing-string.patch"
	"${FILESDIR}/${PN}-6.3.0-use-proper-install-paths.patch"
)

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="
dev-cpp/glog
dev-libs/libfmt
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DROCPROFILER_REGISTER_BUILD_GLOG=OFF
		-DROCPROFILER_REGISTER_BUILD_FMT=OFF
		-DROCPROFILER_REGISTER_BUILD_SAMPLES=OFF
	)
	if use test; then
		mycmakeargs+=(-DROCPROFILER_REGISTER_BUILD_TESTS=$(usex test))
	fi

	cmake_src_configure
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( 19 )

inherit cmake flag-o-matic llvm-r1

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/ROCm/ROCR-Runtime/"
	inherit git-r3
	S="${WORKDIR}/${P}/src"
else
	SRC_URI="https://github.com/ROCm/ROCR-Runtime/archive/rocm-${PV}.tar.gz -> ${P}.tar.gz"
	#S="${WORKDIR}/ROCR-Runtime-rocm-${PV}/runtime/hsa-runtime"
	S="${WORKDIR}/ROCR-Runtime-rocm-${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Radeon Open Compute Runtime"
HOMEPAGE="https://github.com/ROCm/ROCR-Runtime"
PATCHES=(
	"${FILESDIR}/${PN}-6.3.0_no-aqlprofiler.patch"
	"${FILESDIR}/${PN}-6.3.0-extend-isa-compatibility-check.patch"
)

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"
IUSE="debug"

COMMON_DEPEND="dev-libs/elfutils
	x11-libs/libdrm"
DEPEND="${COMMON_DEPEND}
	>=sys-process/numactl-2.0.18
	>=dev-libs/rocm-device-libs-${PV}
	>=dev-libs/rocprofiler-register-${PV}
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
		llvm-core/lld:${LLVM_SLOT}=
	')
"
RDEPEND="${DEPEND}"
BDEPEND="app-editors/vim-core"
	# vim-core is needed for "xxd"

src_prepare() {
	# Gentoo installs "*.bc" to "/usr/lib" instead of a "[path]/bitcode" directory ...
	sed -e "s:-O2:--rocm-path=${EPREFIX}/usr/lib/ -O2:" -i runtime/hsa-runtime/image/blit_src/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	# -Werror=odr
	# https://bugs.gentoo.org/856091
	# https://github.com/ROCm/ROCR-Runtime/issues/182
	filter-lto

	use debug || append-cxxflags "-DNDEBUG"
	cmake_src_configure
}


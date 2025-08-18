# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
inherit cmake flag-o-matic llvm.org python-any-r1 toolchain-funcs

DESCRIPTION="BOLT post-link profile-guided binary optimizer"
HOMEPAGE="https://llvm.org/"

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA"
SLOT="20"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc x86 ~arm64-macos ~x64-macos"
IUSE="debug test"
# There are no cmake targets for tests, not sure they're even supported
# RESTRICT="!test? ( test )"
RESTRICT=test

DEPEND="
	~llvm-core/llvm-${PV}[debug=]
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	llvm-core/llvm:20
	test? (
		$(python_gen_any_dep 'dev-python/lit[${PYTHON_USEDEP}]')
	)
"

LLVM_COMPONENTS=( llvm bolt cmake )
#LLVM_COMPONENTS=( llvm bolt cmake llvm/lib/Target/AArch64 llvm/lib/Target/RISCV llvm/lib/Target/X86 )
LLVM_USE_TARGETS=llvm+eq

#PATCHES=(
#	"${FILESDIR}"/no-shared-libs.patch
#	"${FILESDIR}"/${PN}-tools-bat-dump-link-mainlib.patch
#	"${FILESDIR}"/${PN}-targets-no-linkage-link-mainlib.patch
#)

llvm.org_set_globals

python_check_deps() {
	python_has_version "dev-python/lit[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_unpack() {
	llvm.org_src_unpack

	# Directory ${WORKDIR}/llvm does not exist with USE="-test",
	# but LLVM_MAIN_SRC_DIR="${WORKDIR}/llvm" is set below,
	# and ${LLVM_MAIN_SRC_DIR}/../libunwind/include is used by build system
	# (lld/MachO/CMakeLists.txt) and is expected to be resolvable
	# to existent directory ${WORKDIR}/libunwind/include.
	mkdir -p "${WORKDIR}/llvm" || die
}

src_configure() {
	# LLVM_ENABLE_ASSERTIONS=NO does not guarantee this for us, #614844
	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"

	use elibc_musl && append-ldflags -Wl,-z,stack-size=2097152

	local mycmakeargs=(
		-DLLVM_ENABLE_PROJECTS="bolt"
		-DLLVM_INCLUDE_BENCHMARKS=OFF
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/${LLVM_MAJOR}"
		-DLLVM_ROOT="${ESYSROOT}/usr/lib/llvm/${LLVM_MAJOR}"
		-DLLVM_DIR="${ESYSROOT}/usr/lib/llvm/${LLVM_ROOT}/lib64/cmake/llvm"
		-DBOLT_ENABLE_RUNTIME=ON
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_SKIP_RPATH=ON
		-DLLVM_INCLUDE_TESTS=$(usex test)
		-DLLVM_LINK_LLVM_DYLIB=ON
		-DLLVM_TARGETS_TO_BUILD="AArch64;RISCV;X86"
	)
	# Bolt only supports 3 targets, easier to build them all than to filter LLVM_TARGETS

	use test && mycmakeargs+=(
		-DLLVM_EXTERNAL_LIT="${EPREFIX}/usr/bin/lit"
		-DLLVM_LIT_ARGS="$(get_lit_flags)"
		-DPython3_EXECUTABLE="${PYTHON}"
	)

	tc-is-cross-compiler &&	mycmakeargs+=(
		-DLLVM_TABLEGEN_EXE="${BROOT}/usr/lib/llvm/${LLVM_MAJOR}/bin/llvm-tblgen"
	)

	cmake_src_configure
}

src_compile() {
	cmake_build bolt llvm-bat-dump
}

src_install() {
	DESTDIR="${D}" cmake_build install-bolt
	into "${EPREFIX}/usr/lib/llvm/${LLVM_MAJOR}"
	dobin "${WORKDIR}/llvm_build/bin/llvm-bat-dump"
}

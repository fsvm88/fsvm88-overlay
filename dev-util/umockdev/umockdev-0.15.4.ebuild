# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )

inherit meson multilib-minimal python-any-r1 vala

DESCRIPTION="Mock hardware devices for creating unit tests"
HOMEPAGE="https://github.com/martinpitt/umockdev/"
SRC_URI="https://github.com/martinpitt/umockdev/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~ppc64 x86"
IUSE="+introspection static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="
	virtual/libudev:=[${MULTILIB_USEDEP}]
	>=dev-libs/glib-2.32:2[${MULTILIB_USEDEP}]
	introspection? ( >=dev-libs/gobject-introspection-1.32:= )
"
DEPEND="${RDEPEND}
	test? (
		${PYTHON_DEPS}
		dev-libs/libgudev:=[${MULTILIB_USEDEP}] )
	app-arch/xz-utils
	dev-lang/vala
	>=dev-util/gtk-doc-am-1.14
	virtual/pkgconfig
"

# Tests seem to hang forever
# RESTRICT="test"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	default
}

multilib_src_configure() {
	local ECONF_SOURCE="${S}"
	export VALAC="$(type -P valac-$(vala_best_api_version))"
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_test() {
	meson_src_test
}

multilib_src_install() {
	einstalldocs
	find "${D}" -name '*.la' -delete || die
	meson_src_install
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=XAOC
DIST_VERSION=0.034
inherit virtualx perl-module

DESCRIPTION="Perl bindings for GTK+ 3"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	x11-libs/gtk+:3[introspection]
	dev-perl/Cairo-GObject
	>=dev-perl/Glib-Object-Introspection-0.43.0
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

src_test(){
	virtx perl-module_src_test
}

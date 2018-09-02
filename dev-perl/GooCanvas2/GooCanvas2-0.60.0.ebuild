# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=PERLMAX
DIST_VERSION=0.06
inherit perl-module

DESCRIPTION="Perl interface to GooCanvas2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	x11-libs/goocanvas:2.0
	dev-perl/Glib-Object-Introspection
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

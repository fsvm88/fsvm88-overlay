# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=XAOC
DIST_VERSION=1.004
inherit perl-module

DESCRIPTION="Integrate Cairo into the Glib type system"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	x11-libs/cairo[glib]
	dev-perl/glib-perl
	dev-perl/Cairo
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	dev-perl/ExtUtils-Depends
	dev-perl/ExtUtils-PkgConfig
"

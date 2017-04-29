# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-3.6.9.ebuild,v 1.1 2012/12/03 20:00:07 ago Exp $

EAPI="3"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
ETYPE="sources"
inherit kernel-2
detect_version

REISER4_VERSION="3.6.4"
REISER4_NAME="reiser4-for-${REISER4_VERSION}.patch.gz"
REISER4_URI="mirror://sourceforge/reiser4/reiser4-for-linux-3.x/${REISER4_NAME}"

DESCRIPTION="Full sources for the Linux kernel plus Reiser4 patches"
HOMEPAGE="http://forums.gentoo.org/viewtopic-p-5200706.html"
SRC_URI="${KERNEL_URI} ${REISER4_URI}"

UNIPATCH_LIST="${DISTDIR}/${REISER4_NAME}"
UNIPATCH_STRICTORDER="yes"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="deblob"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}

# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs eutils

DESCRIPTION="Tool for ATI cards to show all underclock/overclock statuses"
HOMEPAGE="http://websupport.sk/~stanojr/projects/atipower/"
SRC_URI="http://websupport.sk/~stanojr/projects/atipower/atipower-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc ~sparc"
IUSE=""

RESTRICT="mirror"

src_unpack() {
	unpack ${A}
	cd ${S}
#	sed -i "s:-O2:${CFLAGS}:" Makefile
	epatch "${FILESDIR}"/atipower_includes.patch
}

src_compile() {
#	make atipower || die "make failed"
	emake || die "emake failed"
}

src_install() {
#	dosbin atipower || die
#	dodoc README


#	doexe atipower || die "failed doexe"
	dobin atipower || die "failed merging binary"
#	insinto /etc/conf.d
#	newins "${FILESDIR}"/atipower.confd atipower
#	exeinto /etc/init.d
#	newexe "${FILESDIR}"/atipower.rc atipower
}

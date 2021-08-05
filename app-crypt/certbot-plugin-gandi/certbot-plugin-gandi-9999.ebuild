# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python{3_7,3_8,3_9})

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="https://github.com/obynio/certbot-plugin-gandi"
	inherit git-r3
	S=${WORKDIR}/${PN}-${PV}
else
	SRC_URI="https://gitlab.com/obynio/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="amd64 ~arm ~arm64 ~x86"
	S=${WORKDIR}/${PN%-dns-gandi}-${PV}/${PN}
fi

inherit distutils-r1

DESCRIPTION="Gandi plugin for certbot (Let's Encrypt Client)"
HOMEPAGE="https://gitlab.com/csplugin/certbot-plugin-gandi https://letsencrypt.org/"
KEYWORDS="amd64 x86"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

CDEPEND=">=dev-python/setuptools-1.0[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	>=app-crypt/certbot-0.36.0[${PYTHON_USEDEP}]
	>=app-crypt/acme-0.36.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"

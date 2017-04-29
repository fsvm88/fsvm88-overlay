# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

MY_PN="SpeechRecognition"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SpeechRecognition allows to use libraries such as sphinx or google ASR for speech recognition."
HOMEPAGE="https://github.com/Uberi/speech_recognition"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 amd64-linux x86-linux"
IUSE="test"

# git is needed for tests, see https://bugs.launchpad.net/pbr/+bug/1326682 and https://bugs.gentoo.org/show_bug.cgi?id=561038
DEPEND="
	>=app-accessibility/pocketsphinx-0.8
	>=dev-python/pyaudio-0.2.9"
PDEPEND=""

S="${WORKDIR}/${MY_P}"


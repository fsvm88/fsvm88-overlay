# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME_ORG_MODULE="NetworkManager"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{3_6,3_7} )

inherit bash-completion-r1 gnome2 multilib python-any-r1 virtualx udev multilib-minimal

DESCRIPTION="A set of co-operative tools that make networking simple and straightforward"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"

LICENSE="GPL-2+"
SLOT="0" # add subslot if libnm-util.so.2 or libnm-glib.so.4 bumps soname version

RESTRICT="!test? ( test )"

IUSE="gnutls +nss"
REQUIRED_USE="
	|| ( nss gnutls )
"

KEYWORDS="~alpha ~amd64 arm arm64 ~ia64 ppc ppc64 ~sparc x86"

# gobject-introspection-0.10.3 is needed due to gnome bug 642300
# wpa_supplicant-0.7.3-r3 is needed due to bug 359271
COMMON_DEPEND="
	>=dev-libs/dbus-glib-0.100[${MULTILIB_USEDEP}]
	net-libs/libndp[${MULTILIB_USEDEP}]
	>=virtual/libudev-175:=[${MULTILIB_USEDEP}]
	nss? ( >=dev-libs/nss-3.11:=[${MULTILIB_USEDEP}] )
	!nss? ( gnutls? (
		dev-libs/libgcrypt:0=[${MULTILIB_USEDEP}]
		>=net-libs/gnutls-2.12:=[${MULTILIB_USEDEP}] ) )
"
RDEPEND="${COMMON_DEPEND}
"
DEPEND="${COMMON_DEPEND}
"

PATCHES=(
	"${FILESDIR}"/${PN}-data-fix-the-ID_NET_DRIVER-udev-rule.patch
	"${FILESDIR}"/1.18.4-iwd1-compat.patch # included in 1.21.3+
	"${FILESDIR}"/${PN}-only-glib-and-util.patch
)

python_check_deps() {
	if use test; then
		has_version "dev-python/dbus-python[${PYTHON_USEDEP}]" &&
		has_version "dev-python/pygobject:3[${PYTHON_USEDEP}]"
	fi
}

sysfs_deprecated_check() {
	ebegin "Checking for SYSFS_DEPRECATED support"

	if { linux_chkconfig_present SYSFS_DEPRECATED_V2; }; then
		eerror "Please disable SYSFS_DEPRECATED_V2 support in your kernel config and recompile your kernel"
		eerror "or NetworkManager will not work correctly."
		eerror "See https://bugs.gentoo.org/333639 for more info."
		die "CONFIG_SYSFS_DEPRECATED_V2 support detected!"
	fi
	eend $?
}

pkg_pretend() {
	if use kernel_linux; then
		get_version
		if linux_config_exists; then
			sysfs_deprecated_check
		else
			ewarn "Was unable to determine your kernel .config"
			ewarn "Please note that if CONFIG_SYSFS_DEPRECATED_V2 is set in your kernel .config, NetworkManager will not work correctly."
			ewarn "See https://bugs.gentoo.org/333639 for more info."
		fi

	fi
}

src_prepare() {
	DOC_CONTENTS="To modify system network connections without needing to enter the
		root password, add your user account to the 'plugdev' group."

	gnome2_src_prepare
}

multilib_src_configure() {
	local myconf=(
		--disable-more-warnings
		--disable-static
		--localstatedir=/var
		--disable-lto
		--disable-config-plugin-ibft
		--disable-qt
		--without-netconfig
		--with-dbus-sys-dir=/etc/dbus-1/system.d
		# We need --with-libnm-glib (and dbus-glib dep) as reverse deps are
		# still not ready for removing that lib, bug #665338
		--with-libnm-glib
		--without-nmcli
		--with-udev-dir="$(get_udevdir)"
		--with-config-plugins-default=keyfile
		--with-ebpf=no
		--disable-concheck
		#--with-crypto=$(usex nss nss gnutls)
		--with-session-tracking=no
		--without-libaudit
		--disable-bluez5-dun
		--without-dhclient
		--without-dhcpcd
		--disable-introspection
		--disable-json-validation
		--disable-ppp
		--without-libpsl
		--without-modem-manager-1
		--without-nmtui
		--without-ofono
		--disable-ovs
		--disable-polkit
		--disable-polkit-agent
		--without-resolvconf
		--without-selinux
		--without-systemd-journal
		--disable-teamdctl
		$(multilib_native_use_enable test tests)
		--disable-vala
		--without-valgrind
		--without-iwd
		--without-wext
		--disable-wifi
	)

	if multilib_is_native_abi; then
		# work-around man out-of-source brokenness, must be done before configure
		ln -s "${S}/docs" docs || die
		ln -s "${S}/man" man || die
	fi

	ECONF_SOURCE=${S} runstatedir="/run" gnome2_src_configure "${myconf[@]}"
}

multilib_src_compile() {
	local targets=(
		libnm-util/libnm-util.la
		libnm-glib/libnm-glib.la
	)
	emake "${targets[@]}"
}

multilib_src_test() {
	if use test && multilib_is_native_abi; then
		python_setup
		virtx emake check
	fi
}

multilib_src_install() {
	local targets=(
		install-libLTLIBRARIES
	)
	emake DESTDIR="${D}" "${targets[@]}"
}

pkg_postinst() {
	gnome2_pkg_postinst
}

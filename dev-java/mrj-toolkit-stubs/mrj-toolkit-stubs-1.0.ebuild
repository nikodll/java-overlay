# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit java-pkg

MY_PN="MRJToolkitStubs"
DESCRIPTION=""
HOMEPAGE="http://developer.apple.com/samplecode/MRJToolkitStubs/MRJToolkitStubs.html"
SRC_URI="http://developer.apple.com/samplecode/MRJToolkitStubs/${MY_PN}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre"

src_install() {
	java-pkg_newjar ${WORKDIR}/${MY_PN}/${MY_PN}.zip ${MY_PN}.jar
}

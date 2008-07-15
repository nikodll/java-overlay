# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Simple Logging Facade for Java"
HOMEPAGE="http://www.slf4j.org/"
SRC_URI="http://dev.gentoo.org/~serkan/distfiles/${P}-sources.jar"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	dev-java/slf4j-api"
DEPEND=">=virtual/jdk-1.4
	dev-java/slf4j-api
	app-arch/unzip"

S="${WORKDIR}"

EANT_GENTOO_CLASSPATH="slf4j-api"

src_unpack() {
	unpack ${A}
	cp -v "${FILESDIR}"/build.xml . || die
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc org
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
COMMIT="7e534c3"
MY_P="hawtjni-project-${PV}"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A JNI code generator based on the generator used by the Eclipse SWT project"
HOMEPAGE="http://jansi.fusesource.org/"
SRC_URI="https://github.com/fusesource/hawtjni/tarball/${MY_P} -> ${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/fusesource-hawtjni-${COMMIT}/${PN}"
JAVA_SRC_DIR="src/main/java"

java_prepare() {
	# Easier to use java-pkg-simple.
	rm -v pom.xml || die
}

src_install() {
	java-pkg-simple_src_install
	dodoc ../{changelog,notice,readme}.md
}

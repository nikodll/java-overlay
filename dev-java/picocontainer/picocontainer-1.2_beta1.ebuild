# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/picocontainer/picocontainer-1.1-r1.ebuild,v 1.1 2006/08/01 12:22:41 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Small footprint Dependency Injection container"
HOMEPAGE="http://www.picocontainer.org"
MY_PV=${PV//_beta/-beta-}
MY_P=${PN}-${MY_PV}
SRC_URI="http://dist.codehaus.org/${PN}/distributions/${MY_P}-src.tar.gz"
LICENSE="PicoContainer"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5
	source? ( app-arch/zip )
	"
#	test? (
#	    >=dev-java/junit-3.8.1
#	)"
S=${WORKDIR}/container

src_unpack() {
	unpack ${A}
	cd ${S}
	# Don't run tests automatically 
	sed -i -e 's/compile,test/compile/' build.xml

# doesn't pass internal test even when trying vanilla build.xml that fetches own libs
#	if use test ; then
#    	    mkdir -p target/lib
#	    cd target/lib
#	    java-pkg_jar-from junit junit-3.8.1.jar
#	fi
}

src_compile() {
	local antflags="-Dfinal.name=${PN} -Dnoget=true jar"
	eant ${antflags} $(use_doc)
}

#src_test() {
#	local antflags="-Dfinal.name=${PN} -Dnoget=true test"
#	eant ${antflags}
#}

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/api
	use source && java-pkg_dosrc src/java/org
}

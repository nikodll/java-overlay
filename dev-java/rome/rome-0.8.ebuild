# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit java-pkg

DESCRIPTION="An open source set of Atom/RSS Java utilities that make it easy to work in Java with most syndication formats"
HOMEPAGE="https://rome.dev.java.net/"
SRC_URI="http://rome.dev.java.net/files/documents/1764/30987/${P}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	~dev-java/jdom-1.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from jdom-1.0
}

src_compile() {
	local antflags="-Dnoget=true jar"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "ant failed"
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r docs/api
	use source && java-pkg_dosrc src/java/*
}

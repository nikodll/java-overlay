# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

# jython depends on java-config, so don't add it or things will break
PYTHON_COMPAT=( python3_{7,8,9} )

inherit git-r3 distutils-r1 eutils

EGIT_REPO_URI="https://anongit.gentoo.org/git/proj/java-config.git"

DESCRIPTION="Java environment configuration tool"
HOMEPAGE="https://www.gentoo.org/proj/en/java/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="2"
KEYWORDS=""
IUSE=""

RDEPEND="
	sys-apps/baselayout-java
	sys-apps/portage"

python_test() {
	esetup.py test || die
}

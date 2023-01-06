# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: gradle.eclass
# @MAINTAINER:
# Gentoo Java Project <java@gentoo.org>
# @AUTHOR:
# Florian Schmaus <flow@gentoo.org>
# @BLURB: Utility functions for the gradle build system.
# @DESCRIPTION:
# Utility functions for the gradle build system.
# WARNING: This eclass is currently experimental and
# subject to change.

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_GRADLE_ECLASS} ]] ; then
_GRADLE_ECLASS=1

inherit edo

# @ECLASS_VARIABLE: EGRADLE_MIN
# @DEFAULT_UNSET
# @DESCRIPTION:
# Minimum required gradle version.

# @ECLASS_VARIABLE: EGRADLE_MAX_EXCLUSIVE
# @DEFAULT_UNSET
# @DESCRIPTION:
# First gradle version that is not supported.

# @ECLASS_VARIABLE: EGRADLE_OVERWRITE
# @USER_VARIABLE
# @DEFAULT_UNSET
# @DESCRIPTION:
# User-specified overwrite of the used gradle binary.

# @FUNCTION: gradle-set_EGRADLE
# @DESCRIPTION:
# Set the EGRADLE environment variable.
gradle-set_EGRADLE() {
	[[ -n ${EGRADLE} ]] && return

	if [[ -n ${EGRADLE_OVERWRITE} ]]; then
		export EGRADLE="${EGRADLE_OVERWRITE}"
		return
	fi

	local candidates candidate selected selected_ver

	candidates=$(compgen -c gradle-)
	for candidate in ${candidates}; do
		if [[ ! ${candidate} =~ gradle(-bin)?-([.0-9]+) ]]; then
			continue
		fi

		local ver
		if (( ${#BASH_REMATCH[@]} == 3 )); then
			ver="${BASH_REMATCH[2]}"
		else
			ver="${BASH_REMATCH[1]}"
		fi

		if [[ -n ${EGRADLE_MIN} ]] \
			   && ver_test "${ver}" -lt "${EGRADLE_MIN}"; then
			# Candidate does not stisfy EGRADLE_MIN condition.
			continue
		fi

		if [[ -n ${EGRADLE_MAX_EXCLUSIVE} ]] \
			   && ver_test "${ver}" -ge "${EGRADLE_MAX_EXCLUSIVE}"; then
			# Candidate does not satisfy EGRADLE_MAX_EXCLUSIVE condition.
			continue
		fi

		if [[ -n ${selected_ver} ]] \
			   && ver_test "${selected_ver}" -gt "${ver}"; then
			# Candidate is older than the currently selected candidate.
			continue
		fi

		selected="${candidate}"
		selected_ver="${ver}"
	done

	if [[ -z ${selected} ]]; then
		die "Could not find (suitable) gradle installation in PATH"
	fi

	export EGRADLE="${selected}"
	export EGRADLE_VER="${ver}"
}

# @FUNCTION: egradle
# @USAGE: [gradle-args]
# @DESCRIPTION
# Invoke gradle
egradle() {
	gradle-set_EGRADLE

	# TODO --no-build-cache ?
	local gradle_args=(
		--console=plain
		--info
		--stacktrace
		--no-daemon
		--offline
		--no-build-cache
		--gradle-user-home "${T}/gradle_user_home"
		--project-cache-dir "${T}/gradle_project_cache"
	)

	edo "${EGRADLE}" "${gradle_args[@]}" ${@}
}

fi

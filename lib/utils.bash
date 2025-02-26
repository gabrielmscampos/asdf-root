#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/root-project/root"
TOOL_NAME="root"
TOOL_TEST="root --version"

curl_opts=(-fsSL)

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version="$1"

	echo "* Downloading $TOOL_NAME release $version..."
	git clone --branch v${version} --depth=1 https://github.com/root-project/root.git $ASDF_DOWNLOAD_PATH
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}"
	local base_path="/tmp/asdf-root/root-build"
	local build_root="${base_path}/build_root"
	local install_prefix="${base_path}/install_prefix"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$build_root"
		mkdir -p "$install_prefix"
		mkdir -p "$install_path"

		# Build
		local n_cores_build=$(($(nproc --all)-1))
		cmake -S "$ASDF_DOWNLOAD_PATH" -B "$build_root" -DCMAKE_INSTALL_PREFIX=${install_prefix}
		cmake --build "$build_root" --target install -j${n_cores_build}

		# Copy build files to final destination
		cp -r "$install_prefix"/* "$install_path"

		# Remove build files
		rm -rf "$base_path"

		# Assert thisroot exists.
		local thisroot="${install_path}/bin/thisroot.sh"
		if [ ! -e "$thisroot" ]; then
			fail "Expected to find $thisroot."
		fi

		# Assert root is executable
		local tool_executable="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		local tool_cmd="${install_path}/bin/${tool_executable}"
		test -x "$tool_cmd" || fail "Expected $tool_cmd to be executable."

		# Instruct user to source thisroot.sh in his shell
		echo
		echo "${TOOL_NAME} (version ${version}) is installed now."
		echo
		echo "To get started it is recommended to configure your shell to source thisroot script."
		echo "${TOOL_NAME} will launch without sourcing it, however python bindings will not work."
		echo "You can do this by adding this to your shell (.bash, .zshrc):"
		echo
		echo "source ${thisroot}"
		echo
		echo "To confirm that ${TOOL_NAME} was installed correctly, you can run:"
		echo
		echo "${TOOL_TEST}"
		echo
		echo "To confirm that python bindings are working, you can run:"
		echo
		echo "python -c 'import ROOT'"

	) || (
		rm -rf "$install_path"
		rm -rf "$base_path"
		rm -rf "$ASDF_DOWNLOAD_PATH"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

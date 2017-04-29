# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit multilib-build eutils python-r1 distutils-r1 git-r3 python-utils-r1

DESCRIPTION="Open source software library for numerical computation using data flow graphs."
HOMEPAGE="http://www.tensorflow.org/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/tensorflow/tensorflow.git"
if [[ ${PV} != 9999 ]]; then
	EGIT_COMMIT="${PV}"
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cray cuda +system-protobuf"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	 dev-python/six[${PYTHON_USEDEP}]
"
DEPEND=">=dev-util/bazel-0.1.0
	dev-lang/swig
	${RDEPEND}"

python_prepare() {
	if use cray; then
		sed -i "s:/bin/bash:/usr/bin/env bash:" third_party/gpus/cuda/cuda_config.sh || die "Failed to patch third_party/gpus/cuda/cuda_config.sh"
		sed -i "s:/usr/bin/gcc:${GCC_PATH}/snos/bin/gcc:" third_party/gpus/crosstool/clang/bin/crosstool_wrapper_driver_is_not_gcc || die "Failed to patch third_party/gpus/crosstool/clang/bin/crosstool_wrapper_driver_is_not_gcc"
	fi
	
	python_includes=( "$(${EPYTHON} -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")" "$(${EPYTHON} -c "import numpy; print(numpy.get_include())")" )
	sed -i "s:-Wl,-rpath,third_party/gpus/cuda/lib64:-Wl,-rpath,$CUDATOOLKIT_HOME/lib64:" tensorflow/core/platform/default/build_config/BUILD || die
	eapply_user
}

python_configure_all() {
	if use cuda; then
        	export TF_NEED_CUDA=1
        	export CUDA_TOOLKIT_PATH="$CUDATOOLKIT_HOME"
		save_IFS=$IFS
		IFS=':'
		prefixes="${EPREFIX}:${PORTAGE_READONLY_EPREFIXES}"
		for p in $prefixes; do
			echo "$p"
			if [ -e "${p}/usr/lib/libcudnn.so" ]; then
				prefix=$p
			fi
		done
		IFS=$save_IFS
		[ -z "$prefix" ] && die "Could not find CUDNN!"
        	export CUDNN_INSTALL_PATH="${prefix}/usr"
		myconfig="--config=cuda"
	else
		export TV_NEED_CUDA=0
		myconfig=""
	fi
	export PYTHON_BIN_PATH="$(which python2)"
	export TF_NEED_GCP=0
	export TF_NEED_HDFS=0
	export TF_NEED_OPENCL=0
	export PYTHON_LIB_PATH="${BUILD_DIR}/lib"
	#export USE_DEFAULT_PYTHON_LIB_PATH=1
	./configure
	echo "PYTHON_PATH=$(which python2)"
	echo "PYTHON_LIB_PATH=${BUILD_DIR}/lib"
	echo "Configure done!"
}

python_compile() {
	bazel build -c opt $myconfig //tensorflow/tools/pip_package:build_pip_package
	echo "${T}/${EPYTHON}_package"
	mkdir "${T}"/${EPYTHON}_package || ( bazel shutdown && die "Cannot create temporary directory." )
	bazel-bin/tensorflow/tools/pip_package/build_pip_package "${T}/${EPYTHON}_package" || ( bazel shutdown && die "Failed to build package" )
	mkdir "${WORKDIR}"/tensorflow_built-${EPYTHON/./_} || ( bazel shutdown && die "Cannot create temporary directory." )
	mkdir "${WORKDIR}"/tensorflow_built || ( bazel shutdown && die "Cannot create temporary directory." )
	tar -xvf "${T}/${EPYTHON}_package"/tensorflow-${PV}.tar.gz -C "${WORKDIR}"/tensorflow_built-${EPYTHON/./_} --strip-components=1 || ( bazel shutdown && die "Cannot extract built package archive" )
	S="${WORKDIR}/tensorflow_built"
	bazel shutdown
}

python_install() {
	distutils-r1_python_install
	use system-protobuf && rm -rf "${ED}"/usr/lib/${EPYTHON}/site-packages/google/
	rm -rf "${ED}"/usr/lib/${EPYTHON}/site-packages/external/
}


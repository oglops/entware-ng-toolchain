
FROM noonien/openwrt-buildroot
MAINTAINER oglop

ARG arch=armv5

RUN buildDeps='vim rsync' \
    && sudo apt-get update \
    && sudo apt-get install -y $buildDeps \
	&& git clone https://github.com/Entware-ng/Entware-ng.git \
	&& cd Entware-ng \
	&& make package/symlinks \
	&& cp configs/.config .config \
	&& make tools/install \
	&& make toolchain/install \
	&& sed -e "s/|| xloc.file == '\\\0'/|| xloc.file[0] == '\\\0'/" -i build_dir/toolchain-arm_xscale_gcc-6.3.0_glibc-2.23_eabi/gcc-6.3.0/gcc/ubsan.c \
	&& make toolchain/install \
	&& make target/compile

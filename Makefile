CROSS_ARCH ?= x86
CROSS_PATH ?= /opt/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/


sffmpeg:
	@mkdir -p build && \
	cd build && \
	cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE=Release -DCROSS_ARCH=$(CROSS_ARCH) -DCROSS_PREFIX=$(CROSS_PATH)/arm-linux-gnueabihf\- .. && \
	make

distclean:
	@rm -rf build

clean:

deb:
	@debuild -i -us -uc -b

deb-armv7:
	@debuild -eCROSS_ARCH=armv7 --prepend-path=${CROSS_PATH} -i -us -uc -b -aarmhf

debclean:
	@debuild clean

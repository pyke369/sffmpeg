sffmpeg:
	@mkdir -p build && \
	cd build && \
	cmake -j`cat /proc/cpuinfo|grep ^processor|wc -l` -DCMAKE_BUILD_TYPE=Release .. && \
	make

distclean:
	@rm -rf build

clean:

deb:
	@debuild -i -us -uc -b

debclean:
	@debuild clean

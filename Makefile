sffmpeg:
	@mkdir -p build && \
	cd build && \
	cmake -DCMAKE_BUILD_TYPE=Release .. && \
	make

distclean:
	@rm -rf build
	@rm -rf debian/.debhelper
	debian/rules clean

clean:

deb:
	@debuild -i -us -uc -b

debclean:
	@debuild clean

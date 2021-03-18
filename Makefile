CONCURRENCY=`cat /proc/cpuinfo |grep ^processor |wc -l`

sffmpeg:
	@mkdir -p build && cd build && cmake -DCONCURRENCY=$(CONCURRENCY) .. && \
	make -k -j$(CONCURRENCY) 2>&1 |tee build.log

clean:
distclean: clean
	@rm -rf build

deb:
	@debuild -i -us -uc -b
debclean:
	@debuild -- clean
	@rm -f ../sffmpeg_*

build:
	./build.sh

clean:
	rm -rf build

install:
	install -v -d $(DESTDIR)/var/lib/grafana
	cp -vr build/out $(DESTDIR)/var/lib/grafana/plugins

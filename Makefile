prefix ?= /usr/local
sysconfdir ?= ${prefix}/etc
localstatedir ?= ${prefix}/var
datarootdir ?= ${prefix}/share
bindir ?= ${prefix}/bin
plugindir ?= ${datarootdir}/builddist/plugins

#top_srcdir ?= $(shell pwd)

.SUFFIXES: .in

FRONTEND = builddist
PLUGINS = plugins/tee plugins/progressbar plugins/timestamp
GEN_SCRIPTS = $(FRONTEND) $(PLUGINS)

all: $(GEN_SCRIPTS)

%: %.in
	sed -e "s|@prefix@|${prefix}|g"  \
	    -e "s|@sysconfdir@|${sysconfdir}|g" \
	    -e "s|@localstatedir@|${localstatedir}|g" \
	    -e "s|@datarootdir@|${datarootdir}|g" \
	    -e "s|@plugindir@|${plugindir}|g" \
	    -e "s|@bindir@|${bindir}|g" $^ > $@

install: all
	mkdir -pv ${DESTDIR}${bindir} ${DESTDIR}${plugindir}
	install -v -m 0755 $(FRONTEND) ${DESTDIR}${bindir}
	install -v -m 0755 $(PLUGINS) ${DESTDIR}${plugindir}

clean:
	rm -f $(GEN_SCRIPTS)


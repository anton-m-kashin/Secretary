BUILDDIR = .build
EXECUTABLENAME = Secretary
COMPILEDPATH = $(BUILDDIR)/release/
INSTALLPATH = /usr/local/bin/
EXAMPLEPLIST = ./Examples/Secrets.plist
EXAMPLESWIFT = ./Examples/Secrets.swift

.PHONY: build clean install uninstall run

build:
	swift build \
		--build-path $(BUILDDIR) \
		--configuration release
		
clean:
	swift package \
		--build-path $(BUILDDIR) \
		clean

install: build
	cp $(COMPILEDPATH)$(EXECUTABLENAME) $(INSTALLPATH)$(EXECUTABLENAME)

uninstall:
	test -f $(INSTALLPATH)$(EXECUTABLENAME) \
		&& rm $(INSTALLPATH)$(EXECUTABLENAME)

run:
	swift run $(EXECUTABLENAME) \
		$(EXAMPLEPLIST) \
		$(EXAMPLESWIFT)

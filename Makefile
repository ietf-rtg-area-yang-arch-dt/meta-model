#assumes standard yang modules installed in ../yang, customize as needed
#  e.g., based on a 'cd .. ; git clone https://github.com/YangModels/yang.git'
YANGIMPORT_BASE = ../yang
MODELS		= network-device.tree

PLUGPATH   := $(shell echo `find $(YANGIMPORT_BASE) -name \*.yang | sed 's,/[a-z0-9A-Z@_\-]*.yang$$,,' | uniq` | tr \  :)
PYTHONPATH := $(shell echo `find /usr/lib* /usr/local/lib* -name  site-packages ` | tr \  :)

%.tree: %.yang
	@echo Generating $@
	@PYTHONPATH=$(PYTHONPATH) pyang --ietf -f tree -p $(PLUGPATH) $< > $@


all:	device.tree $(MODELS)

device.tree:  network-device.tree
	@echo Copying $@
	@cp -p $< $@ 

vars:
	echo PYTHONPATH=$(PYTHONPATH)
	echo PLUGPATH=$(PLUGPATH)

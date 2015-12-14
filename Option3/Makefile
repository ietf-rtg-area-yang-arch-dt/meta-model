DRAFT  = draft-rtgyangdt-rtgwg-device-model.xml
MODELS = \
	network-device.yang \
	logical-network-element.yang \
	networking-instance.yang

#assumes standard yang modules installed in ../yang, customize as needed
#  e.g., based on a 'cd .. ; git clone https://github.com/YangModels/yang.git'
YANGIMPORT_BASE = ../../yang
PLUGPATH   := $(shell echo `find $(YANGIMPORT_BASE) -name \*.yang | sed 's,/[a-z0-9A-Z@_\-]*.yang$$,,' | uniq` | tr \  :)
PYTHONPATH := $(shell echo `find /usr/lib* /usr/local/lib* -name  site-packages ` | tr \  :)

TREES := $(MODELS:.yang=.tree)
%.tree: %.yang
	@echo Updating $< revision date
	@rm -f $<.prev; cp -p $< $<.prev 
	@sed 's/revision.\"[0-9]*\-[0-9]*\-[0-9]*\"/revision "'`date +%F`'"/' < $<.prev > $<
	@diff $<.prev $<
	@echo Generating $@	
	@PYTHONPATH=$(PYTHONPATH) pyang --ietf -f tree -p $(PLUGPATH) $< > $@  || exit 0

all:	$(TREES) $(DRAFT)

vars:
	echo PYTHONPATH=$(PYTHONPATH)
	echo PLUGPATH=$(PLUGPATH)

$(DRAFT): $(MODELS)
	@rm -f $@.prev; cp -p $@ $@.prev 
	@for model in $? ; do \
		echo Updating $@ based on $$model		 	; \
		base=`echo $$model | cut -d. -f 1` 		 	; \
		start_stop=(`awk 'BEGIN{pout=1}				\
			/^<CODE BEGINS> file .'$${base}'/ 		\
				{pout=0; print NR-1;} 			\
			pout == 0 &&/^<CODE ENDS>/ 			\
				{pout=1; print NR;}' $@.prev`) 		; \
		head -$${start_stop[0]}    $@.prev    		> $@	;\
		echo '<CODE BEGINS> file "'$${base}'@'`date +%F`'.yang"'>> $@;\
		cat $$model					>> $@	;\
		tail -n +$${start_stop[1]} $@.prev 		>> $@	;\
	done
	diff -bw $@.prev $@ || exit 0

#OLD
draft-rtgyangdt-rtgwg-device-model.raw: network-device.yang
	@echo Updating $@ based on $<
	@rm -f $@.prev; cp -p $@ $@.prev
	@i=(`awk '$$1=="<CODE"{print NR}' $@.prev`);  \
		head -$${i[0]} $@.prev    > $@ ;\
		sed 's/^/   /' $<         >> $@;\
		tail -n +$${i[1]} $@.prev >> $@
	diff -bw $@.prev $@ || exit 0

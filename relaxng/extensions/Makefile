REMOVESCH=0
RDFALREL="RDFa Lite DocBook Extension 0.1"

TOOLSDEP=../tools/make-schema.xpl

.PHONY: clean

all: schemas

schemas: rdfalite.rnc

clean:
	rm -rf build
	rm -f *.rnc *.rng *.sch

%.sch: %.rng
	saxon $< ../tools/schematron.xsl $@

rdfalite.rnc: $(TOOLSDEP) $(wildcard rdfalite/*.rnc)
	mkdir -p build/rdfalite
	calabash ../tools/make-schema.xpl schema=rdfalite release=$(RDFALREL) remove-schematron=$(REMOVESCH)

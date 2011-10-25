REMOVESCH=0
DBVER="V5.1b5"
DBREL="DocBook $(DBVER)"
XIREL="DocBook XInclude $(DBVER)"
SDBREL="Simplified DocBook $(DBVER)"
ASMREL="DocBook Assembly $(DBVER)"
FORMREL="DocBook Forms $(DBVER)"
ITSREL="DocBook ITS $(DBVER)"
PUBREL="DocBook Publishers $(DBVER)-1"
SLIREL="DocBook Slides $(DBVER)-1"
WEBREL="DocBook Website $(DBVER)-1"

TOOLSDEP=../tools/make-schema.xpl

.PHONY: clean

all: schemas

schemas: docbook.rnc assembly.rnc docbookxi.rnc sdocbook.rnc dbforms.rnc dbits.rnc \
     publishers.rnc slides.rnc slides-full.rnc website.rnc website-full.rnc

doc: defguide.rnd publishers.rnd sdocbook.rnd

clean:
	rm -rf build
	rm -f *.rnc *.rng *.sch

docbook.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc)
	mkdir -p build/docbook
	calabash ../tools/make-schema.xpl schema=docbook release=$(DBREL) remove-schematron=$(REMOVESCH)

assembly.rnc: docbook.rnc $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard assembly/*.rnc)
	mkdir -p build/assembly
	mkdir -p build/docbook
	saxon docbook.rng ../tools/all-patterns.xsl build/docbook/any.docbook.rng
	trang build/docbook/any.docbook.rng build/docbook/any.docbook.rnc
	calabash ../tools/make-schema.xpl schema=assembly release=$(ASMREL) remove-schematron=$(REMOVESCH)

docbookxi.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard docbookxi/*.rnc)
	mkdir -p build/docbookxi
	calabash ../tools/make-schema.xpl schema=docbookxi release=$(XIREL) remove-schematron=$(REMOVESCH)

defguide.rnd: docbook.rnc assembly.rnc
	mkdir -p build/defguide
	calabash ../tools/make-doc.xpl schema=defguide

sdocbook.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard sdocbook/*.rnc)
	mkdir -p build/sdocbook
	calabash ../tools/make-schema.xpl schema=sdocbook release=$(SDBREL) remove-schematron=$(REMOVESCH)

sdocbook.rnd: sdocbook.rnc
	mkdir -p build/sdocbook
	calabash ../tools/make-doc.xpl schema=sdocbook

dbforms.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard dbforms/*.rnc)
	mkdir -p build/dbforms
	calabash ../tools/make-schema.xpl schema=dbforms release=$(FORMREL) remove-schematron=$(REMOVESCH)

dbits.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard dbits/*.rnc)
	mkdir -p build/dbits
	calabash ../tools/make-schema.xpl schema=dbits release=$(ITSREL) remove-schematron=$(REMOVESCH)

publishers.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard publishers/*.rnc)
	mkdir -p build/publishers
	calabash ../tools/make-schema.xpl schema=publishers release=$(PUBREL) remove-schematron=$(REMOVESCH)

publishers.rnd: publishers.rnc
	mkdir -p build/publishers
	calabash ../tools/make-doc.xpl schema=publishers

slides.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard slides/*.rnc)
	mkdir -p build/slides
	calabash ../tools/make-schema.xpl schema=slides release=$(SLIREL) remove-schematron=$(REMOVESCH)

slides-full.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard slides/*.rnc) $(wildcard slides-full/*.rnc)
	mkdir -p build/slides-full
	calabash ../tools/make-schema.xpl schema=slides-full release=$(SLIREL) remove-schematron=$(REMOVESCH)

website.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard website/*.rnc)
	mkdir -p build/website
	calabash ../tools/make-schema.xpl schema=website release=$(SLIREL) remove-schematron=$(REMOVESCH)

website-full.rnc: $(TOOLSDEP) $(wildcard docbook/*.rnc) $(wildcard website/*.rnc) $(wildcard website-full/*.rnc)
	mkdir -p build/website-full
	calabash ../tools/make-schema.xpl schema=website-full release=$(SLIREL) remove-schematron=$(REMOVESCH)

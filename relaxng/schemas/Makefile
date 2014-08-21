REMOVESCH=0
DBVER=V5.1CR3
DBREL="DocBook $(DBVER)"
XIREL="DocBook XInclude $(DBVER)"
SDBREL="Simplified DocBook $(DBVER)"
ASMREL="DocBook Assembly $(DBVER)"
FORMREL="DocBook Forms $(DBVER)"
ITSREL="DocBook ITS $(DBVER)"
PUBREL="DocBook Publishers $(DBVER)-1"
SLIREL="DocBook Slides $(DBVER)-1"
WEBREL="DocBook Website $(DBVER)-1"

MKSCHEMA=../tools/make-schema.xpl

empty :=
space := $(empty) $(empty)

CLASSPATH=$(subst  $(space),:,$(wildcard ../../lib/*.jar))
SAXON=java -cp $(CLASSPATH) -jar ../../lib/saxon9he.jar
CALABASH=java -cp $(CLASSPATH) com.xmlcalabash.drivers.Main
TRANG=java -cp $(CLASSPATH) com.thaiopensource.relaxng.translate.Driver

all: schemas doc

schemas: docbook.rnc assembly.rnc docbookxi.rnc sdocbook.rnc dbforms.rnc dbits.rnc \
     publishers.rnc slides.rnc slides-full.rnc website.rnc website-full.rnc \
     docbook.sch docbookxi.sch assembly.sch publishers.sch dbits.sch

doc: defguide.rnd publishers.rnd sdocbook.rnd

docbook.sch: docbook.rng
docbookxi.sch: docbookxi.rng
assembly.sch: assembly.rng
publishers.sch: publishers.rng
dbits.sch: dbits.rng

%.sch: %.rng
	$(SAXON) -s:$< -xsl:../tools/schematron.xsl -o:$@

docbook.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc)
	mkdir -p build/docbook
	$(CALABASH) $(MKSCHEMA) schema=docbook release=$(DBREL) remove-schematron=$(REMOVESCH)
	$(MAKE) -C docbook/test

assembly.rnc: docbook.rnc $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard assembly/*.rnc)
	mkdir -p build/assembly
	mkdir -p build/docbook
	$(SAXON) -s:docbook.rng -xsl:../tools/all-patterns.xsl -o:build/docbook/any.docbook.rng
	$(TRANG) build/docbook/any.docbook.rng build/docbook/any.docbook.rnc
	$(CALABASH) $(MKSCHEMA) schema=assembly release=$(ASMREL) remove-schematron=$(REMOVESCH)
	$(MAKE) -C assembly/test

docbookxi.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard docbookxi/*.rnc)
	mkdir -p build/docbookxi
	$(CALABASH) $(MKSCHEMA) schema=docbookxi release=$(XIREL) remove-schematron=$(REMOVESCH)

defguide.rnd: docbook.rnc assembly.rnc
	mkdir -p build/defguide
	$(CALABASH) ../tools/make-doc.xpl schema=defguide

sdocbook.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard sdocbook/*.rnc)
	mkdir -p build/sdocbook
	$(CALABASH) $(MKSCHEMA) schema=sdocbook release=$(SDBREL) remove-schematron=$(REMOVESCH)

sdocbook.rnd: sdocbook.rnc
	mkdir -p build/sdocbook
	$(CALABASH) ../tools/make-doc.xpl schema=sdocbook

dbforms.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard dbforms/*.rnc)
	mkdir -p build/dbforms
	$(CALABASH) $(MKSCHEMA) schema=dbforms release=$(FORMREL) remove-schematron=$(REMOVESCH)

dbits.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard dbits/*.rnc)
	mkdir -p build/dbits
	$(CALABASH) $(MKSCHEMA) schema=dbits release=$(ITSREL) remove-schematron=$(REMOVESCH)

publishers.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard publishers/*.rnc)
	mkdir -p build/publishers
	$(CALABASH) $(MKSCHEMA) schema=publishers release=$(PUBREL) remove-schematron=$(REMOVESCH)
	$(MAKE) -C publishers/test

publishers.rnd: publishers.rnc
	mkdir -p build/publishers
	$(CALABASH) ../tools/make-doc.xpl schema=publishers

slides.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard slides/*.rnc)
	mkdir -p build/slides
	$(CALABASH) $(MKSCHEMA) schema=slides release=$(SLIREL) remove-schematron=$(REMOVESCH)

slides-full.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard slides/*.rnc) $(wildcard slides-full/*.rnc)
	mkdir -p build/slides-full
	$(CALABASH) $(MKSCHEMA) schema=slides-full release=$(SLIREL) remove-schematron=$(REMOVESCH)

website.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard website/*.rnc)
	mkdir -p build/website
	$(CALABASH) $(MKSCHEMA) schema=website release=$(SLIREL) remove-schematron=$(REMOVESCH)

website-full.rnc: $(MKSCHEMA) $(wildcard docbook/*.rnc) $(wildcard website/*.rnc) $(wildcard website-full/*.rnc)
	mkdir -p build/website-full
	$(CALABASH) $(MKSCHEMA) schema=website-full release=$(SLIREL) remove-schematron=$(REMOVESCH)

clean:
	rm -rf build
	rm -f *.rnc *.rng *.sch
	$(MAKE) -C docbook/test clean
	$(MAKE) -C assembly/test clean
	$(MAKE) -C publishers/test clean

TRANG=/sourceforge/docbook/buildtools/runtrang
XSLT=/sourceforge/docbook/buildtools/xslt
XSLTPROC=xsltproc
PERL=perl
XPROC=calabash

.PHONY: clean

DEBUG=0
TARGETS=docbook assembly publishers

all: $(addsuffix .dtd,$(TARGETS))

clean:
	rm -rf build
	rm -f $(addsuffix .rng,$(TARGETS))
	rm -f $(addsuffix .dtd,$(TARGETS))

# FIXME: the dependencies should include all the source .rnc files

########################################################################

.gitignore:
	@echo .gitignore > $@
	@echo build >> $@
	@for f in $(addsuffix .rng,$(TARGETS)); do echo $$f; done >> $@
	@for f in $(addsuffix .dtd,$(TARGETS)); do echo $$f; done >> $@

########################################################################
# DocBook DTD

docbook.dtd: docbook.rng docbook/override.xml
	$(XPROC) -isource=$< -oresult=$@ ../tools/rng2dtd/rng2dtd.xpl override=docbook/override.xml debug=$(DEBUG)

docbook.rng: build/docbook/docbook.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

docbook.sch: build/docbook/docbook.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/docbook/docbook.rng: docbook/docbook.rnc \
             $(filter-out docbook/docbook.rnc, $(wildcard docbook/*.rnc))
	@if !([ -d build/docbook ]); then mkdir -p build/docbook; fi
	$(TRANG) $< $@

build/docbook/docbook.rnx: build/docbook/docbook.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/docbook/docbook.rnx, use.extensions=1
	$(XSLT) -saxon build/docbook/docbook.rnx, ../tools/augment.xsl build/docbook/docbook.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/docbook/docbook.rnx,, > $@

########################################################################
# DocBook Assembly
#
# FIXME: these dependencies are a bit of a hack...

assembly.dtd: assembly.rng
	touch $@

assembly.rng: build/assembly/assembly.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

assembly.sch: build/assembly/assembly.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/assembly/assembly.rng: assembly/assembly.rnc \
             $(filter-out assembly/assembly.rnc, $(wildcard assembly/*.rnc))
	$(MAKE) -C ../schemas build/docbook/any.docbook.rnc
	@if !([ -d build/assembly ]); then mkdir -p build/assembly; fi
	$(TRANG) $< $@

build/assembly/assembly.rnx: build/assembly/assembly.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/assembly/assembly.rnx, use.extensions=1
	$(XSLT) -saxon build/assembly/assembly.rnx, ../tools/augment.xsl build/assembly/assembly.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/assembly/assembly.rnx,, > $@

########################################################################
# Publishers

publishers.dtd: publishers.rng
	touch $@

publishers.rng: build/publishers/publishers.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

publishers.sch: build/publishers/publishers.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/publishers/publishers.rng: publishers/publishers.rnc \
             $(filter-out publishers/publishers.rnc, $(wildcard publishers/*.rnc))
	@if !([ -d build/publishers ]); then mkdir -p build/publishers; fi
	$(TRANG) $< $@

build/publishers/publishers.rnx: build/publishers/publishers.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/publishers/publishers.rnx, use.extensions=1
	$(XSLT) -saxon build/publishers/publishers.rnx, ../tools/augment.xsl build/publishers/publishers.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/publishers/publishers.rnx,, > $@

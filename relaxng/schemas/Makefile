TRANG=/sourceforge/docbook/buildtools/runtrang
XSLT=/sourceforge/docbook/buildtools/xslt
XSLTPROC=xsltproc
PERL=perl

.PHONY: clean

TARGETS=docbook docbookxi assembly dbits dbforms transclusion sdocbook \
        publishers \
        slides slides-full website website-full

RNDFILES=defguide.rnd publishers.rnd sdocbook.rnd

all: $(RNDFILES) $(addsuffix .rnc,$(TARGETS)) $(addsuffix .sch,$(TARGETS))

clean:
	rm -rf build
	rm -f $(RNDFILES) $(addsuffix .sch,$(TARGETS))
	rm -f $(addsuffix .rnc,$(TARGETS)) $(addsuffix .rng,$(TARGETS))

########################################################################
# General rules

.gitignore:
	@echo .gitignore > $@
	@echo build >> $@
	@for f in $(RNDFILES); do echo $$f; done >> $@
	@for f in $(addsuffix .sch,$(TARGETS)); do echo $$f; done >> $@
	@for f in $(addsuffix .rnc,$(TARGETS)); do echo $$f; done >> $@
	@for f in $(addsuffix .rng,$(TARGETS)); do echo $$f; done >> $@

%.rnc: %.rng
	$(TRANG) $< $@

########################################################################
# DocBook

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
# DocBook XInclude

docbookxi.rng: build/docbookxi/docbookxi.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

docbookxi.sch: build/docbookxi/docbookxi.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/docbookxi/docbookxi.rng: docbookxi/docbookxi.rnc \
             $(filter-out docbookxi/docbookxi.rnc, $(wildcard docbookxi/*.rnc))
	@if !([ -d build/docbookxi ]); then mkdir -p build/docbookxi; fi
	$(TRANG) $< $@

build/docbookxi/docbookxi.rnx: build/docbookxi/docbookxi.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/docbookxi/docbookxi.rnx, use.extensions=1
	$(XSLT) -saxon build/docbookxi/docbookxi.rnx, ../tools/augment.xsl build/docbookxi/docbookxi.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/docbookxi/docbookxi.rnx,, > $@

########################################################################
# DocBook: The Definitive Guide library
# Note that this only builds the .rnd file. The .rnd file is used to
# make the documentation; there's nothing interesting about the
# schema for any other purpose

defguide.rnd: build/defguide/defguide.rnx
	$(XSLTPROC) -output $@ ../tools/rngdocxml.xsl $<

build/defguide/defguide.rng: defguide/defguide.rnc
	@if !([ -d build/defguide ]); then mkdir -p build/defguide; fi
	$(TRANG) $< $@

build/defguide/defguide.rnx: build/defguide/defguide.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/defguide/defguide.rnx, use.extensions=1
	$(XSLT) -saxon build/defguide/defguide.rnx, ../tools/augment.xsl build/defguide/defguide.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/defguide/defguide.rnx,, > $@

########################################################################
# DocBook Assembly

assembly.rng: build/assembly/assembly.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

assembly.sch: build/assembly/assembly.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/assembly/assembly.rng: assembly/assembly.rnc docbook.rnc \
             $(filter-out assembly/assembly.rnc, $(wildcard assembly/*.rnc)) \
             build/docbook/any.docbook.rnc
	@if !([ -d build/assembly ]); then mkdir -p build/assembly; fi
	$(TRANG) $< $@

build/assembly/assembly.rnx: build/assembly/assembly.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/assembly/assembly.rnx, use.extensions=1
	$(XSLT) -saxon build/assembly/assembly.rnx, ../tools/augment.xsl build/assembly/assembly.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/assembly/assembly.rnx,, > $@

# A schema that contains a pattern for any DocBook element

build/docbook/any.docbook.rnc: build/docbook/any.docbook.rng
	$(TRANG) $< $@

build/docbook/any.docbook.rng: docbook.rng
	$(XSLT) $< ../tools/all-patterns.xsl $@

########################################################################
# DocBook ITS

dbits.rng: build/dbits/dbits.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

dbits.sch: build/dbits/dbits.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/dbits/dbits.rng: dbits/dbits.rnc docbook.rnc \
             $(filter-out dbits/dbits.rnc, $(wildcard dbits/*.rnc))
	@if !([ -d build/dbits ]); then mkdir -p build/dbits; fi
	$(TRANG) $< $@

build/dbits/dbits.rnx: build/dbits/dbits.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/dbits/dbits.rnx, use.extensions=1
	$(XSLT) -saxon build/dbits/dbits.rnx, ../tools/augment.xsl build/dbits/dbits.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/dbits/dbits.rnx,, > $@

########################################################################
# DocBook Forms

dbforms.rng: build/dbforms/dbforms.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

dbforms.sch: build/dbforms/dbforms.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/dbforms/dbforms.rng: dbforms/dbforms.rnc docbook.rnc \
             $(filter-out dbforms/dbforms.rnc, $(wildcard dbforms/*.rnc))
	@if !([ -d build/dbforms ]); then mkdir -p build/dbforms; fi
	$(TRANG) $< $@

build/dbforms/dbforms.rnx: build/dbforms/dbforms.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/dbforms/dbforms.rnx, use.extensions=1
	$(XSLT) -saxon build/dbforms/dbforms.rnx, ../tools/augment.xsl build/dbforms/dbforms.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/dbforms/dbforms.rnx,, > $@

########################################################################
# DocBook Transclusion

transclusion.rng: build/transclusion/transclusion.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

transclusion.sch: build/transclusion/transclusion.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/transclusion/transclusion.rng: transclusion/src/db-transclusions.rnc docbook.rnc
	@if !([ -d build/transclusion ]); then mkdir -p build/transclusion; fi
	$(TRANG) $< $@

build/transclusion/transclusion.rnx: build/transclusion/transclusion.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/transclusion/transclusion.rnx, use.extensions=1
	$(XSLT) -saxon build/transclusion/transclusion.rnx, ../tools/augment.xsl build/transclusion/transclusion.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/transclusion/transclusion.rnx,, > $@

########################################################################
# Publishers

publishers.rng: build/publishers/publishers.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

publishers.rnd: build/publishers/publishers.rnx
	$(XSLTPROC) -output $@ ../tools/rngdocxml.xsl $<

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


########################################################################
# Simplified DocBook

sdocbook.rng: build/sdocbook/sdocbook.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

sdocbook.rnd: build/sdocbook/sdocbook.rnx
	$(XSLTPROC) -output $@ ../tools/rngdocxml.xsl $<

sdocbook.sch: build/sdocbook/sdocbook.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/sdocbook/sdocbook.rng: sdocbook/sdocbook.rnc \
             $(filter-out sdocbook/sdocbook.rnc, $(wildcard sdocbook/*.rnc))
	@if !([ -d build/sdocbook ]); then mkdir -p build/sdocbook; fi
	$(TRANG) $< $@

build/sdocbook/sdocbook.rnx: build/sdocbook/sdocbook.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/sdocbook/sdocbook.rnx, use.extensions=1
	$(XSLT) -saxon build/sdocbook/sdocbook.rnx, ../tools/augment.xsl build/sdocbook/sdocbook.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/sdocbook/sdocbook.rnx,, > $@

########################################################################
# Slides

slides.rng: build/slides/slides.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

slides.sch: build/slides/slides.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/slides/slides.rng: slides/slides.rnc \
             $(filter-out slides/slides.rnc, $(wildcard slides/*.rnc))
	@if !([ -d build/slides ]); then mkdir -p build/slides; fi
	$(TRANG) $< $@

build/slides/slides.rnx: build/slides/slides.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/slides/slides.rnx, use.extensions=1
	$(XSLT) -saxon build/slides/slides.rnx, ../tools/augment.xsl build/slides/slides.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/slides/slides.rnx,, > $@

########################################################################
# Slides Full

slides-full.rng: build/slides-full/slides-full.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

slides-full.sch: build/slides-full/slides-full.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/slides-full/slides-full.rng: slides-full/slides-full.rnc \
             $(filter-out slides-full/slides-full.rnc, $(wildcard slides-full/*.rnc))
	@if !([ -d build/slides-full ]); then mkdir -p build/slides-full; fi
	$(TRANG) $< $@

build/slides-full/slides-full.rnx: build/slides-full/slides-full.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/slides-full/slides-full.rnx, use.extensions=1
	$(XSLT) -saxon build/slides-full/slides-full.rnx, ../tools/augment.xsl build/slides-full/slides-full.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/slides-full/slides-full.rnx,, > $@

########################################################################
# Website

website.rng: build/website/website.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

website.sch: build/website/website.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/website/website.rng: website/website.rnc \
             $(filter-out website/website.rnc, $(wildcard website/*.rnc))
	@if !([ -d build/website ]); then mkdir -p build/website; fi
	$(TRANG) $< $@

build/website/website.rnx: build/website/website.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/website/website.rnx, use.extensions=1
	$(XSLT) -saxon build/website/website.rnx, ../tools/augment.xsl build/website/website.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/website/website.rnx,, > $@

########################################################################
# Website Full

website-full.rng: build/website-full/website-full.rnx
	$(XSLTPROC) --param remove-schematron 1 --output $@ ../tools/removedoc.xsl $<

website-full.sch: build/website-full/website-full.rnx
	$(XSLT) -saxon $< ../tools/schematron.xsl $@

build/website-full/website-full.rng: website-full/website-full.rnc \
             $(filter-out website-full/website-full.rnc, $(wildcard website-full/*.rnc))
	@if !([ -d build/website-full ]); then mkdir -p build/website-full; fi
	$(TRANG) $< $@

build/website-full/website-full.rnx: build/website-full/website-full.rng
	$(XSLT) -saxon $< ../tools/include.xsl build/website-full/website-full.rnx, use.extensions=1
	$(XSLT) -saxon build/website-full/website-full.rnx, ../tools/augment.xsl build/website-full/website-full.rnx,, use.extensions=1
	$(PERL) ../tools/cleanup.pl build/website-full/website-full.rnx,, > $@


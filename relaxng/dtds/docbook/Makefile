include _header.mak

REMOVESCHEMATRON=1

SRCS = dtd.rnc

BINARY = dtd.rnd

all:: dtd.rnc dtd.rng docbook.dtd docbook.xsd

clean:: ; rm -f dtd.rng dtd.rnc

$(_OUTTOP)/dtd/dtd.rng: dtd/dtd.rnc

include _footer.mak

dtd.rng: $(basename $(dtd_BINARY)).rnx
	$(XSLTPROC) --param remove-schematron $(REMOVESCHEMATRON) --output $@ $(TOOLS)/removedoc.xsl $<

dtd.rnc: dtd.rng
	$(RUNTRANG) $< $@

docbook.dtd: dtd.rng
	$(MAKE) -C ../tools/rng2dtd docbook.dtd
	cp ../tools/rng2dtd/docbook.dtd .

docbook.xsd: docbook.dtd
	$(RUNTRANG) $< $@

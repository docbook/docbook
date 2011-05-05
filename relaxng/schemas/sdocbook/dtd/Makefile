include _header.mak

REMOVESCHEMATRON=0

SRCS = dtd.rnc

BINARY = dtd.rnd

all:: dtd.rng

clean:: ; rm -f dtd.rng

$(_OUTTOP)/dtd/dtd.rng: dtd/dtd.rnc sdocbook.rnc

include _footer.mak

dtd.rng: $(basename $(dtd_BINARY)).rnx
	$(XSLTPROC) --param remove-schematron $(REMOVESCHEMATRON) --output $@ $(TOOLS)/removedoc.xsl $<


include _header.mak

REMOVESCHEMATRON=1

SRCS = assemblydtd.rnc

BINARY = assemblydtd.rnd

all:: assemblydtd.rnc assemblydtd.rng assembly.dtd assembly.xsd

clean:: ; rm -f assemblydtd.rng assemblydtd.rnc

$(_OUTTOP)/assemblydtd/assemblydtd.rng: assemblydtd/assemblydtd.rnc

include _footer.mak

assemblydtd.rng: $(basename $(assemblydtd_BINARY)).rnx
	$(XSLTPROC) --param remove-schematron $(REMOVESCHEMATRON) --output $@ $(TOOLS)/removedoc.xsl $<

assemblydtd.rnc: assemblydtd.rng
	$(RUNTRANG) $< $@

assembly.dtd: assemblydtd.rng
	$(MAKE) -C ../tools/rng2dtd assembly.dtd
	cp ../tools/rng2dtd/assembly.dtd .

assembly.xsd: assembly.dtd
	$(RUNTRANG) $< $@

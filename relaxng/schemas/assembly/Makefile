include _header.mak

REMOVESCHEMATRON=0

SRCS = assembly.rnc

BINARY = assembly.rnd

all:: assembly.rng assembly.rnc assembly.sch

clean:: ; rm -f assembly.rng assembly.rnc assembly.dtd assembly.sch

$(_OUTTOP)/assembly/assembly.rng: src/annotations.rnc src/bibliography.rnc \
             src/callouts.rnc src/calstbl.rnc \
             src/docbook.rnc src/assembly-core.rnc src/ebnf.rnc src/glossary.rnc \
             src/hier.rnc src/htmltbl.rnc \
             src/index.rnc src/math.rnc src/mathml.rnc \
             src/msgset.rnc src/pool.rnc src/qandaset.rnc \
             src/refentry.rnc src/refsect1.rnc src/sect1.rnc \
             src/svg.rnc src/tasks.rnc src/toc.rnc \
             src/xlink.rnc

include _footer.mak

assembly.rng: $(basename $(assembly_BINARY)).rnx
	$(XSLTPROC) --param remove-schematron $(REMOVESCHEMATRON) --output $@ $(TOOLS)/removedoc.xsl $<

assembly.rnc: assembly.rng
	$(RUNTRANG) $< $@

#assembly.dtd: assembly.rnc
#	$(MAKE) -C ../../tools/rng2dtd assembly.dtd
#	cp ../../tools/rng2dtd/assembly.dtd .

# N.B. the schematron stylesheet is an XSLT 2.0 stylesheet!
assembly.sch: $(basename $(assembly_BINARY)).rnx
	$(SAXON) $< $(TOOLS)/schematron.xsl $@

#assembly.xsd: assembly.dtd
#	$(RUNTRANG) $< $@

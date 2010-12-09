include ../../../../buildtools/Makefile.incl

HTMLSTYLE=../howto/stylesheets/html.xsl
FOSTYLE=../howto/stylesheets/fo.xsl
# below are customizations layers for XSL-NS stylesheets
HTMLNSSTYLE=../howto/stylesheets/html-ns.xsl
FONSSTYLE=../howto/stylesheets/fo-ns.xsl
VARS=

all: transclusion-requirements.html transclusion-requirements.pdf transclusion.html transclusion.pdf

# output using the namespaced stylesheets
#ns: howto.ns.html howto.ns.pdf

%.html : %.xml $(HTMLSTYLE)
	$(JING) -c ../docbook.rnc $<
	$(XSLT) $< $(HTMLSTYLE) $@ toc.max.depth=1 $(VARS)

#%.ns.html : %.xml $(HTMLNSSTYLE)
#	jing -c ../../docbook.rnc $<
#	$(XSLT) $< $(HTMLNSSTYLE) $@ $(VARS)

%.fo : %.xml $(FOSTYLE)
	$(JING) -c ../docbook.rnc $<
	$(XSLT) $< $(FOSTYLE) $@ xep.extensions=1 toc.max.depth=1 $(VARS)

#%.ns.fo : %.xml $(FONSSTYLE)
#	jing -c ../../docbook.rnc $<
#	$(XSLT) $< $(FONSSTYLE) $@ xep.extensions=1 $(VARS)

%.pdf : %.fo
	$(XEP) -quiet $<

#%.ns.pdf : %.ns.fo
#	xep $<

clean:
	$(RM) transclusion-requirements.html
	$(RM) transclusion-requirements.pdf
	$(RM) transclusion.html
	$(RM) transclusion.pdf

HTMLSTYLE=html.xsl
PIPELINE=/projects/docbook/xslt20/xslt/base/pipelines/docbook.xpl
CONDITION=oasis

all: docbook.html

docbook.html: docbook.xml html.xsl
	calabash -isource=$< -oresult=$@ \
	-pprofile.condition=$(CONDITION) \
        $(PIPELINE) style=$(HTMLSTYLE)

docbook.fo: docbook.xml fo.xsl
	$(XJPARSE) $<
	$(XSLT) $< $(FOSTYLE) docbook.fo $(XSLPARAM)

docbook.pdf: docbook.fo
	xep -q $<

clean:
	$(RM) -f *.html *.fo *.pdf

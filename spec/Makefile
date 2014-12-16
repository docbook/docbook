HTMLSTYLE=html.xsl
PIPELINE=/projects/docbook/xslt20/xslt/base/pipelines/docbook.xpl
CONDITION=oasis

all: docbook-v5.1-csd01.html docbook-v5.1-csprd01.html

docbook-v5.1-csd01.html: docbook-v5.1-csd01.xml html.xsl
	calabash -isource=$< -oresult=$@ \
	-pprofile.condition=$(CONDITION) \
        $(PIPELINE) style=$(HTMLSTYLE)

docbook-v5.1-csprd01.html: docbook-v5.1-csprd01.xml html.xsl
	calabash -isource=$< -oresult=$@ \
	-pprofile.condition=$(CONDITION) \
        $(PIPELINE) style=$(HTMLSTYLE)

docbook-v5.1-csd01.xml: csd.xml
	calabash -isource=$< -oresult=$@ xinclude.xpl

docbook-v5.1-csprd01.xml: prd.xml
	calabash -isource=$< -oresult=$@ xinclude.xpl

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

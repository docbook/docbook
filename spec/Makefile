HTMLSTYLE=style/html.xsl
PIPELINE=/projects/docbook/xslt20/xslt/base/pipelines/docbook.xpl
CONDITION=oasis
VPATH=src

all: docbook-v5.1-csd02.html docbook-v5.1-csprd02.html

docbook-v5.1-csd02.html: docbook-v5.1-csd02.xml $(HTMLSTYLE)
	calabash -isource=$< -oresult=$@ \
	-pprofile.condition=$(CONDITION) \
        $(PIPELINE) style=$(HTMLSTYLE)

docbook-v5.1-csprd02.html: docbook-v5.1-csprd02.xml $(HTMLSTYLE)
	calabash -isource=$< -oresult=$@ \
	-pprofile.condition=$(CONDITION) \
        $(PIPELINE) style=$(HTMLSTYLE)

docbook-v5.1-csd02.xml: csd.xml info.xml body.xml
	calabash -isource=$< -oresult=$@ style/xinclude.xpl

docbook-v5.1-csprd02.xml: prd.xml info.xml body.xml
	calabash -isource=$< -oresult=$@ style/xinclude.xpl

docbook.html: docbook.xml $(HTMLSTYLE)
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
	$(RM) -f docbook-v5.1-csd02.xml docbook-v5.1-csprd02.xml

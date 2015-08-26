HTMLSTYLE=style/html.xsl
PIPELINE=/projects/docbook/xslt20/xslt/base/pipelines/docbook.xpl
CONDITION=oasis
VPATH=src
NUM=02

all: docbook-v5.1-csd$(NUM).html docbook-v5.1-csprd$(NUM).html \
     docbook-v5.1-csd$(NUM).pdf docbook-v5.1-csprd$(NUM).pdf

docbook-v5.1-csd$(NUM).html: docbook-v5.1-csd$(NUM).xml $(HTMLSTYLE)
	calabash -isource=$< -oresult=$@ \
	-pprofile.condition=$(CONDITION) \
        $(PIPELINE) style=$(HTMLSTYLE)

docbook-v5.1-csprd$(NUM).html: docbook-v5.1-csprd$(NUM).xml $(HTMLSTYLE)
	calabash -isource=$< -oresult=$@ \
	-pprofile.condition=$(CONDITION) \
        $(PIPELINE) style=$(HTMLSTYLE)

docbook-v5.1-csd$(NUM).xml: csd.xml info.xml body.xml
	calabash -isource=$< -oresult=$@ style/xinclude.xpl

docbook-v5.1-csprd$(NUM).xml: prd.xml info.xml body.xml
	calabash -isource=$< -oresult=$@ style/xinclude.xpl

docbook-v5.1-csd$(NUM).pdf: docbook-v5.1-csd$(NUM).html style/pdf.xpl
	calabash -isource=$< style/pdf.xpl pdf=$@ docid=docbook-v5.1-csd$(NUM)

docbook-v5.1-csprd$(NUM).pdf: docbook-v5.1-csprd$(NUM).html style/pdf.xpl
	calabash -isource=$< style/pdf.xpl pdf=$@ docid=docbook-v5.1-csprd$(NUM)

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
	$(RM) -f docbook-v5.1-csd$(NUM).xml docbook-v5.1-csprd$(NUM).xml

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:s="http://purl.oclc.org/dsdl/schematron"
                version="2.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"
	    omit-xml-declaration="yes"/>

<xsl:strip-space elements="*"/>

<xsl:param name="sch-file" select="'docbook-xsd.sch'"/>

<xsl:template match="element()">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>
  </xsl:copy>
</xsl:template>

<!-- In XSD 1.0, ##other wildcards create a UPA problem with the explicit
     DublinCore elements, so we remove the explicit DublinCore elements
     and change skip to lax. -->
<xsl:template match="xs:group[@ref='db:dublincore.elements']"/>
<xsl:template match="xs:any[@namespace='##other' and processContents='skip']">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="processContents" select="'lax'"/>
    <xsl:apply-templates select="node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="xs:assert"/>

<xsl:template match="s:*"/>

<xsl:template match="xs:annotation[xs:appinfo]"/>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>

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

<xsl:template match="/">
  <xsl:apply-templates/>

  <xsl:result-document href="docbook-xsd.sch">
    <xsl:apply-templates select="/" mode="extractsch"/>
  </xsl:result-document>
</xsl:template>

<xsl:template match="element()">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="xs:assert"/>

<xsl:template match="s:*"/>

<xsl:template match="xs:annotation[xs:appinfo]"/>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
  <xsl:copy/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="/" mode="extractsch">
  <s:schema xmlns:s="http://purl.oclc.org/dsdl/schematron"
            xmlns:db="http://docbook.org/ns/docbook">
    <s:ns prefix="db" uri="http://docbook.org/ns/docbook"/>
    <s:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>

    <xsl:apply-templates mode="extractsch"/>
  </s:schema>
</xsl:template>

<xsl:template match="element()" mode="extractsch">
  <xsl:apply-templates select="*" mode="extractsch"/>
</xsl:template>

<xsl:template match="s:*" mode="extractsch">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()" mode="extractsch"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="xs:assert" mode="extractsch">
  <xsl:variable name="elname" select="(ancestor::xs:element)[1]/@name"/>

  <s:pattern>
    <s:title>Assertion on <xsl:value-of select="$elname"/></s:title>
    <s:rule context="db:{$elname}">
      <s:assert test="{@test}">
        <xsl:value-of select="xs:annotation/xs:documentation"/>
      </s:assert>
    </s:rule>
  </s:pattern>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()"
              mode="extractsch">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>

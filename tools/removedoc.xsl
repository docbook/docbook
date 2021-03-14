<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:ctrl="http://nwalsh.com/xmlns/schema-control/"
		xmlns:s="http://purl.oclc.org/dsdl/schematron"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:dbx="http://sourceforge.net/projects/docbook/defguide/schema/extra-markup"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
		exclude-result-prefixes="exsl ctrl db dbx html"
                version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>
<xsl:strip-space elements="*"/>

<xsl:param name="remove-schematron" select="0"/>

<xsl:template match="db:*"/>
<xsl:template match="dbx:*"/>
<xsl:template match="ctrl:*"/>

<xsl:template match="s:*">
  <xsl:if test="$remove-schematron = 0">
    <xsl:element name="s:{local-name(.)}" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:if>
</xsl:template>

<xsl:template match="rng:element">
  <xsl:element name="{local-name(.)}" namespace="{namespace-uri(.)}">
    <xsl:copy-of select="@*"/>
    <xsl:if test="ancestor::rng:div/db:refpurpose">
      <xsl:element name="a:documentation">
	<xsl:value-of select="ancestor::rng:div/db:refpurpose"/>
      </xsl:element>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="rng:attribute">
  <xsl:element name="{local-name(.)}" namespace="{namespace-uri(.)}">
    <xsl:copy-of select="@*"/>
    <xsl:if test="db:refpurpose">
      <xsl:element name="a:documentation">
	<xsl:value-of select="db:refpurpose"/>
      </xsl:element>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="rng:grammar">
  <xsl:element name="{local-name(.)}" namespace="{namespace-uri(.)}">
    <xsl:for-each select="namespace::*">
      <xsl:if test="local-name(.) != 'dbx' and local-name(.) != ''">
        <xsl:copy/>
      </xsl:if>
    </xsl:for-each>
    <xsl:copy-of select="@*"/>

    <xsl:if test="$remove-schematron = 0">
      <xsl:for-each select="namespace::*">
        <xsl:if test="local-name(.) != 'dbx'
                      and local-name(.) != 'xml'
                      and local-name(.) != ''">
          <s:ns prefix="{local-name(.)}" uri="{.}"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>

    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="*">
  <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="comment()|processing-instruction()|text()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>

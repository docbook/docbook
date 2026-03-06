<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs"
                version="2.0">

<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

<xsl:strip-space elements="*"/>

<xsl:variable name="all_nsdecl" as="xs:string*">
  <xsl:for-each select="//namespace::*[local-name(.) != 'xml' and local-name(.) != '']">
    <xsl:value-of select="concat(local-name(.),'=',string(.))"/>
  </xsl:for-each>
</xsl:variable>

<xsl:variable name="nsdecl" select="distinct-values($all_nsdecl)"/>

<xsl:template match="/*">
  <xsl:element name="{local-name(.)}" namespace="http://relaxng.org/ns/structure/1.0">
    <xsl:for-each select="$nsdecl">
      <xsl:namespace name="{substring-before(.,'=')}" select="substring-after(.,'=')"/>
    </xsl:for-each>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="rng:define" xmlns:rng="http://relaxng.org/ns/structure/1.0">
  <xsl:next-match/>
  <xsl:if test="following-sibling::* or not(parent::rng:div)">
    <xsl:text>&#10;&#10;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="rng:div" xmlns:rng="http://relaxng.org/ns/structure/1.0">
  <xsl:next-match/>
  <xsl:text>&#10;&#10;</xsl:text>
</xsl:template>

<xsl:template match="*">
  <xsl:variable name="node" select="."/>

  <xsl:variable name="name" as="xs:string">
    <xsl:choose>
      <xsl:when test="namespace-uri(.) = 'http://relaxng.org/ns/structure/1.0'">
        <xsl:value-of select="local-name(.)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="decl" select="$nsdecl[substring-after(.,'=') = namespace-uri($node)]"/>
        <xsl:value-of select="concat(substring-before($decl,'='),':',local-name(.))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$name}" namespace="{namespace-uri(.)}">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="comment()|processing-instruction()|text()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>

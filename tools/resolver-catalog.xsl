<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog"
                xmlns:cat="urn:oasis:names:tc:entity:xmlns:xml:catalog"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="cat xs"
                version="3.0">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:param name="schema" required="yes" as="xs:string"/>
<xsl:param name="version" required="yes" as="xs:string"/>

<xsl:template match="cat:catalog">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>
    <nextCatalog catalog="../docbook/schemas/{$schema}/catalog.xml"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="cat:*[@uri]">
  <xsl:copy>
    <xsl:apply-templates select="@* except @uri"/>
    <xsl:attribute name="uri"
                   select="'../docbook/schemas/' || $schema
                           || '/' || $version || '/' || @uri"/>
    <xsl:apply-templates select="node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="element()">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>

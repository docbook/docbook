<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0">

<xsl:template match="element()">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
  <xsl:copy/>
</xsl:template>

<xsl:template match="xs:override[@schemaLocation]">
  <xsl:variable name="fn" select="resolve-uri(@schemaLocation, base-uri(.))"/>
  <xsl:apply-templates select="doc($fn)/xs:schema/node()"/>
  <xs:override>
    <xsl:apply-templates select="@*,node()"/>
  </xs:override>
</xsl:template>

</xsl:stylesheet>

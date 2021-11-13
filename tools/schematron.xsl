<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:s="http://purl.oclc.org/dsdl/schematron"
		xmlns:db="http://docbook.org/ns/docbook"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                version="2.0">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="rng:grammar">
    <s:schema queryBinding="xslt2">
      <s:ns prefix="db" uri="http://docbook.org/ns/docbook"/>
      <s:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
      <s:ns prefix="trans" uri="http://docbook.org/ns/transclusion"/>

      <xsl:for-each-group select="//s:pattern" group-by="s:title">
	<xsl:sort data-type="text" order="ascending"/>

	<s:pattern>
          <s:title>
            <xsl:value-of select="current-grouping-key()"/>
          </s:title>

	  <xsl:for-each-group select="current-group()/s:rule" group-by="@context">
	    <xsl:sort data-type="text" order="ascending"/>

	    <s:rule context="{current-grouping-key()}">

	      <xsl:for-each-group select="current-group()/s:assert" group-by="@test">
		<xsl:sort data-type="text" order="ascending"/>

		<xsl:apply-templates select="current-group()[1]"/>
	      </xsl:for-each-group>

	      <xsl:for-each-group select="current-group()/s:report" group-by="@test">
		<xsl:sort data-type="text" order="ascending"/>

		<xsl:apply-templates select="current-group()[1]"/>
	      </xsl:for-each-group>
	    </s:rule>
	  </xsl:for-each-group>
	</s:pattern>
      </xsl:for-each-group>
    </s:schema>
  </xsl:template>

  <xsl:template match="s:pattern">
    <xsl:variable name="context" select="s:rule[1]/@context"/>

    <xsl:message>pattern for <xsl:value-of select="$context"/></xsl:message>

    <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*">
    <xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>

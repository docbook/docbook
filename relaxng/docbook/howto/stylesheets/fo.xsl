<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

<xsl:import href="../../../../../xsl/fo/docbook.xsl"/>

<xsl:param name="body.start.indent" select="'0pt'"/>
<xsl:param name="title.margin.left" select="'0pt'"/>

<xsl:attribute-set name="urilist">
  <xsl:attribute name="margin-left">0.5in</xsl:attribute>
</xsl:attribute-set>

<xsl:template name="article.titlepage">
  <fo:block text-align="left">
    <xsl:apply-templates select="info" mode="howto-titlepage"/>
  </fo:block>
</xsl:template>

<xsl:template match="info" mode="howto-titlepage">
  <xsl:apply-templates select="title" mode="howto-titlepage"/>
  <xsl:apply-templates select="subtitle" mode="howto-titlepage"/>
  <xsl:apply-templates select="bibliocoverage[@temporal][1]"
		       mode="howto-titlepage"/>
  <xsl:apply-templates select="bibliocoverage[@temporal][1]"
		       mode="version-list"/>
  <xsl:apply-templates select="authorgroup" mode="howto-titlepage"/>
</xsl:template>

<xsl:template match="title" mode="howto-titlepage">
  <fo:block font-size="24pt" font-weight="bold" font-family="sans-serif"
	    margin-bottom="5pt">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="howto-titlepage">
  <fo:block font-size="18pt" font-weight="bold" font-family="sans-serif"
	    margin-bottom="5pt">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="bibliocoverage[@temporal]" mode="howto-titlepage">
  <fo:block font-size="16pt" font-weight="bold" margin-bottom="15pt"
	    font-family="sans-serif">
    <xsl:call-template name="datetime.format">
      <xsl:with-param name="date" select="."/>
      <xsl:with-param name="format" select="'d B Y'"/>
    </xsl:call-template>
  </fo:block>
</xsl:template>

<xsl:template match="bibliocoverage[1]" priority="10"
	      mode="version-list">
  <fo:block font-size="12pt" font-family="sans-serif">This version:</fo:block>

  <fo:block xsl:use-attribute-sets="urilist">
    <xsl:apply-templates select="." mode="datedURI"/>
  </fo:block>

  <fo:block font-size="12pt" font-family="sans-serif">Latest version:</fo:block>
  <fo:block xsl:use-attribute-sets="urilist">
    <fo:inline>http://docbook.org/docs/howto/</fo:inline>
  </fo:block>

  <xsl:if test="following-sibling::bibliocoverage[@temporal]">
    <fo:block font-size="12pt" font-family="sans-serif">
      <xsl:text>Previous version</xsl:text>
      <xsl:if test="count(following-sibling::bibliocoverage[@temporal]) &gt; 1">
	<xsl:text>s</xsl:text>
      </xsl:if>
      <xsl:text>:</xsl:text>
    </fo:block>
    <xsl:apply-templates
	select="following-sibling::bibliocoverage[@temporal]"
	mode="version-list"/>
  </xsl:if>
</xsl:template>

<xsl:template match="bibliocoverage" mode="version-list">
  <xsl:if test="count(preceding-sibling::bibliocoverage[@temporal]) &lt; 4">
    <fo:block xsl:use-attribute-sets="urilist">
      <xsl:apply-templates select="." mode="datedURI"/>
    </fo:block>
  </xsl:if>
</xsl:template>

<xsl:template match="bibliocoverage" mode="datedURI">
  <xsl:variable name="uri">
    <xsl:text>http://docbook.org/docs/howto/</xsl:text>
    <xsl:value-of select="substring(.,1,4)"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="substring(.,6,2)"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="substring(.,9,2)"/>
    <xsl:text>/</xsl:text>
  </xsl:variable>

  <fo:inline>
    <xsl:value-of select="$uri"/>
  </fo:inline>
</xsl:template>

<xsl:template match="authorgroup" mode="howto-titlepage">
  <fo:block font-size="12pt" font-family="sans-serif">
    <xsl:text>Author</xsl:text>
    <xsl:if test="count(author) &gt; 1">s</xsl:if>
    <xsl:text>:</xsl:text>
  </fo:block>
  <xsl:apply-templates select="author" mode="howto-titlepage"/>
</xsl:template>

<xsl:template match="author" mode="howto-titlepage">
  <fo:block xsl:use-attribute-sets="urilist">
    <xsl:apply-templates select="personname"/>
    <xsl:if test="email">
      <xsl:text>, </xsl:text>
      <xsl:apply-templates select="email"/>
    </xsl:if>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
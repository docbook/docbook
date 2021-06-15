<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:param name="version-list" as="xs:string" required="yes"/>
<xsl:param name="distribution" as="xs:string" required="yes"/>
<xsl:param name="uris" as="xs:string" required="yes"/>

<xsl:variable name="versions" select="distinct-values(tokenize($version-list, '\s+'))"/>

<xsl:template match="/">
  <catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog" prefer="public">
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> ............................................................ </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> XML Catalog for DocBook .................................... </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> File catalog.xml ........................................... </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
 Please direct all questions, bug reports, or suggestions for
 changes to the docbook-comment@lists.oasis-open.org mailing list.
 For more information, see http://www.oasis-open.org/.
</xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
 This is a catalog data file for DocBook. It is provided as a
 convenience in building your own catalog files. You need not
 use the filenames listed here, and need not use the filename
 method of identifying storage objects at all. See the
 documentation for detailed information on the files associated
 with the DocBook DTD. See XML Catalogs at
 http://www.oasis-open.org/committees/entity/ for detailed
 information on supplying and using catalog data.
</xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>

    <xsl:for-each select="$versions">
      <xsl:variable name="version" select="."/>
      <xsl:variable name="paths" as="xs:string*">
        <xsl:choose>
          <xsl:when test="$distribution = 'docbook'">
            <xsl:sequence select="('www.oasis-open.org/docbook/xml/v' || $version,
                                  'docbook.org/xml/' || $version,
                                  'www.docbook.org/xml/' || $version,
                                  'cdn.docbook.org/schema/' || $version,
                                  'cdn.docbook.org/schema/docbook-' || $version)"/>
          </xsl:when>
          <xsl:when test="$distribution = 'publishers'">
            <xsl:sequence select="('www.oasis-open.org/docbook/xml/publishers/v' || $version,
                                  'docbook.org/xml/publishers/' || $version,
                                  'www.docbook.org/xml/publishers/' || $version,
                                  'cdn.docbook.org/schema/publishers-'||$version)"/>
          </xsl:when>
          <xsl:when test="$distribution = 'sdocbook'">
            <xsl:sequence select="('docbook.org/xml/website/' || $version,
                                  'www.docbook.org/xml/website/' || $version,
                                  'cdn.docbook.org/schema/website-'||$version)"/>
          </xsl:when>
          <xsl:when test="$distribution = 'website'">
            <xsl:sequence select="('docbook.org/xml/website/' || $version,
                                  'www.docbook.org/xml/website/' || $version,
                                  'cdn.docbook.org/schema/website-'||$version)"/>
          </xsl:when>
          <xsl:when test="$distribution = 'slides'">
            <xsl:sequence select="('docbook.org/xml/slides/' || $version,
                                  'www.docbook.org/xml/slides/' || $version,
                                  'cdn.docbook.org/schema/slides-'||$version)"/>
          </xsl:when>
          <xsl:when test="$distribution = 'dbforms'">
            <xsl:sequence select="('docbook.org/xml/htmlforms/' || $version,
                                  'www.docbook.org/xml/htmlforms/' || $version,
                                  'cdn.docbook.org/schema/htmlforms-'||$version)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:message terminate="yes"
                         select="'Unknown distribution: ' || $distribution"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:for-each select="$paths">
        <xsl:variable name="root" select="."/>
        <xsl:for-each select="tokenize(unparsed-text($uris), '\s+')">
          <xsl:if test="normalize-space(.) != ''">
            <uri name="https://{$root}/{.}" uri="{.}"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </catalog>
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

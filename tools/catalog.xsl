<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog" 
                exclude-result-prefixes="xs"
                version="3.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:param name="title" as="xs:string" select="'XML Catalog'"/>
<xsl:param name="version" as="xs:string" select="'UNKNOWN'"/>
<xsl:param name="prefix" as="xs:string" select="'xml'"/>
<xsl:param name="oasisVersion" as="xs:string" select="''"/>
<xsl:param name="oasisRelease" as="xs:string" select="''"/>
<xsl:param name="uris" as="xs:string" required="yes"/>

<xsl:variable name="files"
              select="tokenize(normalize-space(unparsed-text($uris)), '\s+')
                      [. != 'catalog.xml']"/>

<xsl:template match="/">
  <xsl:variable name="dots" select="'...........................................................'"/>

  <catalog prefer="public">
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> ............................................................ </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
      <xsl:sequence select="concat(' ', $title, ' ',
                                   substring($dots, 1, string-length($dots) - string-length($title)),
                                   ' ')"/>
    </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
 Please direct all questions, bug reports, or suggestions for changes
 to the docbook-comment@lists.oasis-open.org mailing list. For more
 information, see http://www.oasis-open.org/.
</xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
 This is an OASIS XML Catalog file. It is provided as a convenience in
 building your own catalog files. You need not use the filenames
 listed here, and need not use the filename method of identifying
 storage objects at all. See the documentation for detailed
 information on the files associated with the DocBook DTD. See XML
 Catalogs at http://www.oasis-open.org/committees/entity/ for detailed
 information on supplying and using catalog data.
</xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> ............................................................ </xsl:comment>
    <xsl:text>&#10;</xsl:text>

    <xsl:if test="$oasisVersion != '' and $oasisRelease != ''">
        <!-- We don't have official URIs for Publishers yet...only output
        the official URs for DocBook -->
      <xsl:if test="$prefix = 'xml'">
        <xsl:call-template name="catalog-files">
          <xsl:with-param name="comment" select="'The official OASIS URIs'"/>
          <xsl:with-param name="root"
                          select="'docs.oasis-open.org/docbook/docbook/v' || $oasisVersion || '/' || $oasisRelease"/>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$oasisVersion != $version">
        <xsl:call-template name="catalog-files">
          <xsl:with-param name="comment" select="'The docbook.org URIs'"/>
          <xsl:with-param name="root"
                          select="'docbook.org/' || $prefix || '/' || $oasisVersion"/>
        </xsl:call-template>

        <xsl:call-template name="catalog-files">
          <xsl:with-param name="comment" select="'The www.docbook.org URIs (for completeness)'"/>
          <xsl:with-param name="root"
                          select="'www.docbook.org/' || $prefix || '/' || $oasisVersion"/>
        </xsl:call-template>

        <xsl:call-template name="catalog-files">
          <xsl:with-param name="comment" select="'The CDN schemas'"/>
          <xsl:with-param name="root"
                          select="if ($prefix = 'xml')
                                             then 'cdn.docbook.org/schema/' || $oasisVersion
                                             else 'cdn.docbook.org/schema/' || $prefix || '-' || $oasisVersion"/>
          <!-- There shouldn't be any http://cdn URIs. -->
          <xsl:with-param name="schemes" select="'https'"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>

    <xsl:call-template name="catalog-files">
      <xsl:with-param name="comment" select="'The historical OASIS URIs (for backwards compatibility)'"/>
      <xsl:with-param name="root"
                      select="'www.oasis-open.org/docbook/' || $prefix || '/' || $version"/>
    </xsl:call-template>

    <xsl:call-template name="catalog-files">
      <xsl:with-param name="comment" select="'The docbook.org URIs'"/>
      <xsl:with-param name="root"
                      select="'docbook.org/' || $prefix || '/' || $version"/>
    </xsl:call-template>

    <xsl:call-template name="catalog-files">
      <xsl:with-param name="comment" select="'The www.docbook.org URIs (for completeness)'"/>
      <xsl:with-param name="root"
                      select="'www.docbook.org/' || $prefix || '/' || $version"/>
    </xsl:call-template>

    <xsl:call-template name="catalog-files">
      <xsl:with-param name="comment" select="'CDN schemas'"/>
      <xsl:with-param name="root"
                      select="if ($prefix = 'xml')
                              then 'cdn.docbook.org/schema/' || $version
                              else 'cdn.docbook.org/schema/' || $prefix || '-' || $version"/>
      <!-- There shouldn't be any http://cdn URIs. -->
      <xsl:with-param name="schemes" select="'https'"/>
    </xsl:call-template>
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

<xsl:template name="catalog-files">
  <xsl:param name="comment" as="xs:string" required="yes"/>
  <xsl:param name="root" as="xs:string" required="yes"/>
  <xsl:param name="schemes" as="xs:string+" select="('https', 'http')"/>

  <xsl:for-each select="$schemes">
    <group>
      <xsl:text> </xsl:text>
      <xsl:comment>
        <xsl:text> </xsl:text>
        <xsl:sequence select="concat($comment, ', ', .)"/>
        <xsl:text> </xsl:text>
      </xsl:comment>
      <xsl:text>&#10;</xsl:text>

      <xsl:variable name="scheme" select="."/>
      <xsl:for-each select="$files">
        <uri name="{$scheme}://{$root}/{.}" uri="{.}"/>
      </xsl:for-each>
    </group>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:db="http://docbook.org/ns/docbook"
                version="2.0">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="pattern" select="'db._any.docbook'"/>

  <xsl:template match="/">
    <grammar xmlns="http://relaxng.org/ns/structure/1.0">
      <div>
        <db:refname>docbook:*</db:refname>
        <db:refpurpose>Any element from the DocBook namespace</db:refpurpose>

        <define name="{$pattern}">
          <choice>
            <xsl:for-each select="//rng:define[rng:element[@name]]">
              <xsl:sort select="@name"/>
              <ref name="{@name}"/>
            </xsl:for-each>
          </choice>
        </define>
      </div>
    </grammar>
  </xsl:template>

</xsl:stylesheet>

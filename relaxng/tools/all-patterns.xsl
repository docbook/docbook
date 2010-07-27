<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                version="1.0">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="pattern" select="'db.any.docbook'"/>

  <xsl:template match="/">
    <grammar xmlns="http://relaxng.org/ns/structure/1.0">
      <define name="{$pattern}">
        <choice>
          <xsl:for-each select="//rng:define[rng:element[@name]]">
            <xsl:sort select="@name"/>
            <ref name="{@name}"/>
          </xsl:for-each>
        </choice>
      </define>
    </grammar>
  </xsl:template>

</xsl:stylesheet>

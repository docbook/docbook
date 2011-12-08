<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:f="http://www.w3.org/2008/05/XMLSchema-misc"
                exclude-result-prefixes="f"
                version="2.0">

  <!-- This stylesheet is derived from the version in the XSD 1.1 spec -->
  
  <xsl:variable name="overrideElement" as="element(xs:override)"
                select="/xs:schema/xs:override"/>

  <xsl:template match="element(xs:schema) | element(xs:redefine)">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="element(xs:import)|element(xs:annotation)" priority="5">
    <xsl:copy-of select="."/>
  </xsl:template>

  <!--* replace children of xs:schema, xs:redefine, and xs:override
      * which match children of $overrideElement.  Retain others.
      *-->
  <xsl:template match="element(xs:schema)/*
                       | element(xs:redefine)/*
                       | element(xs:override)/*"
    priority="3">
    <xsl:variable name="original" select="."/>
    <xsl:variable name="replacement"
      select="$overrideElement/*
                [node-name(.)=node-name($original)
                 and
                 f:componentName(.)=f:componentName($original)]"/>

    <xsl:copy-of select="($replacement, $original)[1]"/>
  </xsl:template>

  <!--* change xs:override elements:  children which match
      * children of $overrideElement are replaced, others are
      * kept, and at the end all children of $overrideElement
      * not already inserted are added.
      *-->
  <xsl:template match="element(xs:override)" priority="5">
    <xsl:variable name="unmatched" as="element()*">
      <xsl:apply-templates select="$overrideElement/*"
                           mode="copy-unmatched">
        <xsl:with-param name="overriddenOverride" select="/xs:schema"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="empty($unmatched)">
        <!-- good -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>Warning: xs:override contained unmatched components.</xsl:message>
        <xsl:element name="xs:override">
          <xsl:attribute name="schemaLocation">
            <xsl:value-of select="@schemaLocation"/>
          </xsl:attribute>
          <xsl:sequence select="$unmatched"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="copy-unmatched">
    <xsl:param name="overriddenOverride"></xsl:param>
    <xsl:variable name="overriding" select="."/>
    <xsl:variable name="overridden" select="$overriddenOverride/*[
	node-name(.) = node-name($overriding)
	and
	f:componentName(.) = f:componentName($overriding)
      ]"/>

    <xsl:choose>
      <xsl:when test="count($overridden) > 0">
	<!--* do nothing; this element has already been copied *-->
      </xsl:when>
      <xsl:when test="count($overridden) = 0">
	<!--* copy this element, it isn't already there *-->
	<xsl:copy-of select="."/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:function name="f:componentName" as="xs:QName">
    <xsl:param name="component" as="element()"/>
    <xsl:sequence select="
      QName($component/ancestor::xs:schema/@targetNamespace,
            $component/@name)"/>
  </xsl:function>

</xsl:stylesheet>

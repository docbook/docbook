<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0">

<xsl:key name="component" match="xs:*" use="@name"/>

<xsl:template match="/">
  <xsl:variable name="del" as="xs:string*">
    <xsl:value-of select="'notAllowed'"/>
    <xsl:for-each select="//xs:element[@type='db:notAllowed']">
      <xsl:value-of select="string(@name)"/>
    </xsl:for-each>
    <xsl:for-each select="//xs:group[*/xs:element[@ref='db:notAllowed']]">
      <xsl:value-of select="string(@name)"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:call-template name="prune">
    <xsl:with-param name="doc" select="/"/>
    <xsl:with-param name="del" select="$del"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="prune">
  <xsl:param name="doc" as="document-node()"/>
  <xsl:param name="del" as="xs:string*"/>

  <xsl:variable name="proc">
    <xsl:apply-templates>
      <xsl:with-param name="del" select="$del"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:variable name="newdel" as="xs:string*">
    <xsl:for-each select="$proc//xs:group[xs:choice[not(*)]]">
      <xsl:value-of select="string(@name)"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="empty($newdel)">
      <xsl:sequence select="$proc"/>
    </xsl:when>
    <xsl:otherwise>
      <!--
      <xsl:message>Prune more: <xsl:value-of select="$newdel"/></xsl:message>
      -->
      <xsl:call-template name="prune">
        <xsl:with-param name="doc" select="/"/>
        <xsl:with-param name="del" select="($del, $newdel)"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="element()">
  <xsl:param name="del" as="xs:string*"/>

  <xsl:copy>
    <xsl:apply-templates select="@*,node()">
      <xsl:with-param name="del" select="$del"/>
    </xsl:apply-templates>
  </xsl:copy>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
  <xsl:param name="del" as="xs:string*"/>

  <xsl:copy/>
</xsl:template>

<xsl:template match="xs:*[starts-with(@ref,'db:')]"> <!-- FIXME: do namespaces correctly! -->
  <xsl:param name="del" as="xs:string*"/>

  <xsl:choose>
    <xsl:when test="substring-after(@ref,'db:') = $del">
      <!-- delete me -->
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy>
        <xsl:apply-templates select="@*,node()">
          <xsl:with-param name="del" select="$del"/>
        </xsl:apply-templates>
      </xsl:copy>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="xs:*[@name]">
  <xsl:param name="del" as="xs:string*"/>

  <xsl:choose>
    <xsl:when test="@name = $del">
      <!-- delete me -->
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy>
        <xsl:apply-templates select="@*,node()">
          <xsl:with-param name="del" select="$del"/>
        </xsl:apply-templates>
      </xsl:copy>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="xs:element[@type='db:notAllowed']" priority="100">
  <xsl:param name="del" as="xs:string*"/>
</xsl:template>

</xsl:stylesheet>

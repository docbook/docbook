<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xslthl="http://xslthl.sf.net"
		exclude-result-prefixes="xslthl"
                version="1.0">

<xsl:import href="../../../../../xsl/html/profile-docbook.xsl"/>
<xsl:import href="../../../../../xsl/html/highlight.xsl"/>

<xsl:param name="profile.status">final</xsl:param>

<!-- Name used in URIs -->
<xsl:param name="basename" select="/*[1]/@xml:id"/>

<xsl:template name="user.head.content">
  <xsl:param name="node" select="."/>

  <link rel="stylesheet" type="text/css"
	href="http://docbook.org/docs/howto/howto.css" />
</xsl:template>

<xsl:template name="article.titlepage">
  <div class="titlepage">
    <xsl:apply-templates select="articleinfo" mode="howto-titlepage"/>
    <hr/>
  </div>
</xsl:template>

<xsl:template match="articleinfo" mode="howto-titlepage">
  <xsl:apply-templates select="title" mode="howto-titlepage"/>
  <xsl:apply-templates select="subtitle" mode="howto-titlepage"/>
  <xsl:apply-templates select="pubdate[1]" mode="howto-titlepage"/>
  <div class="metadata">
    <xsl:apply-templates select="pubdate[1]" mode="version-list"/>
    <xsl:apply-templates select="authorgroup" mode="howto-titlepage"/>
  </div>
</xsl:template>

<xsl:template match="title" mode="howto-titlepage">
  <h1>
    <xsl:apply-templates/>
  </h1>
</xsl:template>

<xsl:template match="subtitle" mode="howto-titlepage">
  <h2>
    <xsl:apply-templates/>
  </h2>
</xsl:template>

<xsl:template match="pubdate" mode="howto-titlepage">
  <h3>
    <xsl:call-template name="datetime.format">
      <xsl:with-param name="date" select="."/>
      <xsl:with-param name="format" select="'d B Y'"/>
    </xsl:call-template>
  </h3>
</xsl:template>

<xsl:template match="pubdate[1]" priority="10"
	      mode="version-list">
  <h4>This version:</h4>
  <dl class="urilist">
    <dt>
      <xsl:apply-templates select="." mode="datedURI"/>
    </dt>
  </dl>

  <h4>Latest version:</h4>
  <dl class="urilist">
    <dt>
      <span>http://docbook.org/docs/<xsl:value-of select="$basename"/>/</span>
      <xsl:text> (</xsl:text>
      <a href="http://docbook.org/docs/{$basename}/">HTML</a>
      <xsl:text>, </xsl:text>
      <a href="http://docbook.org/docs/{$basename}/{$basename}.xml">XML</a>
      <xsl:text>, </xsl:text>
      <a href="http://docbook.org/docs/{$basename}/{$basename}.pdf">PDF</a>
      <xsl:text>)</xsl:text>
    </dt>
  </dl>

  <xsl:if test="following-sibling::pubdate">
    <h4>
      <xsl:text>Previous version</xsl:text>
      <xsl:if test="count(following-sibling::pubdate) &gt; 1">
	<xsl:text>s</xsl:text>
      </xsl:if>
      <xsl:text>:</xsl:text>
    </h4>
    <dl class="urilist">
      <xsl:apply-templates
	  select="following-sibling::pubdate"
	  mode="version-list"/>
    </dl>
  </xsl:if>
</xsl:template>

<xsl:template match="pubdate" mode="version-list">
  <xsl:if test="count(preceding-sibling::pubdate) &lt; 4">
    <dt>
      <xsl:apply-templates select="." mode="datedURI"/>
    </dt>
  </xsl:if>
</xsl:template>

<xsl:template match="pubdate" mode="datedURI">
  <xsl:variable name="uri">
    <xsl:text>http://docbook.org/docs/</xsl:text>
    <xsl:value-of select="$basename"/>
    <xsl:text>/</xsl:text>
    <xsl:value-of select="substring(.,1,4)"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="substring(.,6,2)"/>
    <xsl:text>-</xsl:text>
    <xsl:value-of select="substring(.,9,2)"/>
    <xsl:text>/</xsl:text>
  </xsl:variable>

  <span>
    <xsl:value-of select="$uri"/>
  </span>
  <xsl:text> (</xsl:text>
  <a href="{$uri}">HTML</a>
  <xsl:text>, </xsl:text>
  <a href="{$uri}{$basename}.xml">XML</a>
  <xsl:text>, </xsl:text>
  <a href="{$uri}{$basename}.pdf">PDF</a>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="authorgroup" mode="howto-titlepage">
  <h4>
    <xsl:text>Author</xsl:text>
    <xsl:if test="count(author) &gt; 1">s</xsl:if>
    <xsl:if test="othercredit">
      <xsl:text> and other credited contributors</xsl:text>
    </xsl:if>
    <xsl:text>:</xsl:text>
  </h4>
  <dl class="authorlist">
    <xsl:apply-templates select="author|othercredit" mode="howto-titlepage"/>
  </dl>
</xsl:template>

<xsl:template match="author|othercredit" mode="howto-titlepage">
  <dt>
    <xsl:apply-templates select="personname"/>
    <xsl:if test="email">
      <xsl:text>, </xsl:text>
      <xsl:apply-templates select="email"/>
    </xsl:if>
    <xsl:if test="@otherclass">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="normalize-space(@otherclass)"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
  </dt>
</xsl:template>

<!-- !!! Namespace stripping will rename db:tag to sgmltag -->
<xsl:template match="sgmltag[not(@class) or (@class='element')]
		        [not(@condition = 'nolink')]">
  <xsl:variable name="baseUri">
    <xsl:choose>
      <xsl:when test="@condition = 'v4'">
	<xsl:text>http://docbook.org/tdg/en/html/</xsl:text>
      </xsl:when>
      <xsl:otherwise>http://docbook.org/tdg5/en/html/</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$basename = 'howto'">  <!-- Make links only in howto -->
      <a href="{$baseUri}{.}.html">
	<xsl:apply-imports/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Support for labels identifying programlisting syntax used -->
<xsl:template match="programlisting[@language]">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:call-template name="anchor"/>

  <xsl:if test="$shade.verbatim != 0">
    <xsl:message>
      <xsl:text>The shade.verbatim parameter is deprecated. </xsl:text>
      <xsl:text>Use CSS instead,</xsl:text>
    </xsl:message>
    <xsl:message>
      <xsl:text>for example: pre.</xsl:text>
      <xsl:value-of select="local-name(.)"/>
      <xsl:text> { background-color: #E0E0E0; }</xsl:text>
    </xsl:message>
  </xsl:if>

  <xsl:choose>
    <xsl:when test="$suppress-numbers = '0'
		    and @linenumbering = 'numbered'
		    and $use.extensions != '0'
		    and $linenumbering.extension != '0'">
      <xsl:variable name="rtf">
	<xsl:apply-templates/>
      </xsl:variable>
      <pre class="{name(.)}">
        <xsl:call-template name="role.label"/>
	<xsl:call-template name="number.rtf.lines">
	  <xsl:with-param name="rtf" select="$rtf"/>
	</xsl:call-template>
      </pre>
    </xsl:when>
    <xsl:otherwise>
      <pre class="{name(.)}">
        <xsl:call-template name="role.label"/>
	<xsl:apply-templates/>
      </pre>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="role.label">
  <span class="rolelabel">
    <xsl:call-template name="brealize">
      <xsl:with-param name="text" select="@language"/>
    </xsl:call-template>
  </span>
</xsl:template>

<xsl:template name="brealize">
  <xsl:param name="text"/>
  <xsl:variable name="head" select="substring($text, 1, 1)"/>
  <xsl:variable name="tail" select="substring($text, 2)"/>

  <xsl:if test="$head != ''">
    <xsl:value-of select="$head"/>
  </xsl:if>
  
  <xsl:if test="$tail != ''">
    <br/>
    <xsl:call-template name="brealize">
      <xsl:with-param name="text" select="$tail"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:param name="highlight.source" select="1"/>

<xsl:template name="language.to.xslthl">
  <xsl:param name="context"/>

  <xsl:if test="$context/@language != '' or not($context/@language)">
    <xsl:text>myxml</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match='xslthl:html' mode="xslthl">
  <b style="color: navy"><xsl:apply-templates mode="xslthl"/></b>
</xsl:template>

</xsl:stylesheet>

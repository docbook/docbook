<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:f="http://docbook.org/xslt/ns/extension"
		xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:m="http://docbook.org/xslt/ns/mode"
		xmlns:t="http://docbook.org/xslt/ns/template"
		xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs='http://www.w3.org/2001/XMLSchema'
		exclude-result-prefixes="db f h m t xlink xs"
                version="2.0">

<xsl:import href="/sourceforge/docbook/xsl2/base/html/docbook.xsl"/>

<xsl:param name="generate.toc" as="element()*">
<tocparam path="appendix" toc="0" title="0"/>
<tocparam path="article"  toc="1" title="1"/>
</xsl:param>

<xsl:param name="section.label.includes.component.label" select="1"/>

<xsl:param name="bibliography.collection" select="'bibliography.xml'"/>

<xsl:param name="docbook.css" select="'docbook.css'"/>

<xsl:param name="linenumbering" as="element()*">
<ln path="literallayout" everyNth="0"/>
<ln path="programlisting" everyNth="0"/>
<ln path="programlistingco" everyNth="0"/>
<ln path="screen" everyNth="0"/>
<ln path="synopsis" everyNth="0"/>
<ln path="address" everyNth="0"/>
<ln path="epigraph/literallayout" everyNth="0"/>
</xsl:param>

<xsl:param name="profile.condition" select="'online'"/>

<!-- ============================================================ -->

<xsl:template name="t:user-head-content">
  <xsl:param name="node" select="."/>
  <link href="http://docs.oasis-open.org/templates/DocBook/spec-0.5/css/oasis-spec.css"
        rel="stylesheet" type="text/css" />

  <style type="text/css">
div.toc p b { 
  font-size: 170%;
  list-style-type: decimal;
  color: #66116D;
}

.rev-added {
  background-color: #AAFFAA;
}

.rev-deleted {
  background-color: #FFAAAA;
  text-decoration: line-through;
}

.rev-changed {
  background-color: #FFFFAA;
}

.rev-off {
  background-color: black;
  text-decoration: none;
}

  </style>
</xsl:template>

<xsl:function name="f:title" as="xs:string">
  <xsl:param name="node" as="node()"/>

  <xsl:value-of select="concat($node/db:info/db:title,
                               ' Version ',
                               $node/db:info/db:productnumber)"/>
</xsl:function>

<!-- ============================================================ -->

<xsl:template match="db:article">
  <xsl:variable name="toc.params"
		select="f:find-toc-params(., $generate.toc)"/>

  <div class="article">
    <div class="titlepage">
      <p>
        <img src="http://docs.oasis-open.org/templates/OASISLogo.jpg"
             alt="OASIS logo" />
      </p>

      <xsl:apply-templates select="db:info"/>
    </div>

    <hr/>
    <xsl:call-template name="make-lots">
      <xsl:with-param name="toc.params" select="$toc.params"/>
      <xsl:with-param name="toc">
        <xsl:call-template name="component-toc">
          <xsl:with-param name="toc.title" select="$toc.params/@title != 0"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <hr/>

    <xsl:apply-templates select="*[not(self::db:info)]"/>
  </div>
</xsl:template>

<xsl:template match="db:article/db:info">
  <div class="head">
    <h1 class="title">
      <xsl:apply-templates select="db:title/node()"/>
      <xsl:text> Version </xsl:text>
      <xsl:value-of select="db:productnumber"/>
    </h1>

    <h2>
      <xsl:value-of select="../@status"/>
    </h2>

    <h2 class="pubdate">
      <xsl:value-of select="format-date(xs:date(db:pubdate[1]),
	                                '[D] [MNn] [Y0001]')"/>
    </h2>

    <xsl:variable name="odnRoot">
      <xsl:value-of select="db:productname[1]"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="db:productnumber[1]"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="'spec'"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="db:releaseinfo[@role='stage'][1]"/>
      <xsl:if test="db:biblioid[@class='pubsnumber'][1] != ''">
        <xsl:text>-</xsl:text>
        <xsl:value-of select="db:biblioid[@class='pubsnumber'][1]"/>
      </xsl:if>
      <xsl:if test="ancestor::*[@xml:lang][1]
		    and ancestor::*[@xml:lang][1]/@xml:lang != 'en'">
	<xsl:text>-</xsl:text>
	<xsl:value-of select="ancestor::*[@xml:lang][1]/@xml:lang"/>
      </xsl:if>
    </xsl:variable>

    <div class="uris">
      <dl>
        <dt class="loc-heading">Specification URIs:</dt>
      </dl>

      <dl>
	<dt class="loc-heading">This Version:</dt>
	<xsl:for-each select="('.html','.xml')">
	  <dd>
	    <a href="{$odnRoot}{.}">
	      <xsl:text>http://docs.oasis-open.org/docbook/specs/</xsl:text>
	      <xsl:value-of select="$odnRoot"/>
	      <xsl:value-of select="."/>
	    </a>
            <xsl:if test="position() = 1"> (Authoritative)</xsl:if>
	  </dd>
	</xsl:for-each>

<!--
        <xsl:if test="db:bibliorelation[@type='replaces']">
          <xsl:variable name="r" select="string((db:bibliorelation[@type='replaces'])[1]/@xlink:href)"/>
          <dt class="loc-heading">Previous Version:</dt>
          <xsl:for-each select="('.html','.pdf','.xml')">
            <dd>
              <a href="{$r}{.}">
                <xsl:text>http://docs.oasis-open.org/docbook/specs/</xsl:text>
                <xsl:value-of select="$r"/>
                <xsl:value-of select="."/>
              </a>
            </dd>
          </xsl:for-each>
        </xsl:if>
-->
      </dl>
    </div>

    <div class="committee">
      <dl>
	<dt class="loc-heading">Technical Committee:</dt>
	<xsl:for-each select="db:org/db:orgdiv">
	  <dd>
	    <a href="{@xlink:href}">
	      <xsl:value-of select="."/>
	    </a>
	  </dd>
	</xsl:for-each>
      </dl>
    </div>

    <div class="chairs">
      <dl>
	<dt class="loc-heading">
	  <xsl:text>Chair</xsl:text>
	  <xsl:if test="count(db:othercredit[@otherclass = 'chair']) &gt; 1">
	    <xsl:text>s</xsl:text>
	  </xsl:if>
          <xsl:text>:</xsl:text>
	</dt>
	<xsl:apply-templates select="db:othercredit[@otherclass = 'chair']"
			     mode="spec.titlepage"/>
      </dl>
    </div>

    <div class="editors">
      <dl>
	<xsl:variable name="editors" select="db:authorgroup/db:editor|db:editor"/>
	<dt class="loc-heading">
	  <xsl:text>Editor</xsl:text>
	  <xsl:if test="count($editors) &gt; 1">
	    <xsl:text>s</xsl:text>
	  </xsl:if>
          <xsl:text>:</xsl:text>
	</dt>
	<xsl:apply-templates select="$editors" mode="spec.titlepage"/>
      </dl>
    </div>

    <xsl:variable name="replaces" select="db:bibliorelation[@type='replaces']"/>
    <xsl:variable name="supersedes" select="db:bibliorelation[@othertype='supersedes']"/>
    <xsl:variable name="related" select="db:bibliorelation[@type='references']"/>

    <xsl:if test="$replaces | $supersedes | $related">
      <div class="related">
        <dl>
          <dt class="loc-heading">Related Work:</dt>
	  <dd>
            <xsl:if test="$replaces|$supersedes">
              <p>This specification replaces or supersedes:</p>
              <div class="itemizedlist">
                <ul>
                  <xsl:for-each select="$replaces|$supersedes">
                    <li>
                      <a href="{@xlink:href}">
                        <xsl:value-of select="@xlink:href"/>
                      </a>
                    </li>
                  </xsl:for-each>
                </ul>
              </div>
            </xsl:if>
            <xsl:if test="$related">
              <p>This specification is related to:</p>
              <div class="itemizedlist">
                <ul>
                  <xsl:for-each select="$related">
                    <li>
                      <a href="{@xlink:href}">
                        <xsl:value-of select="@xlink:href"/>
                      </a>
                    </li>
                  </xsl:for-each>
                </ul>
              </div>
            </xsl:if>
	  </dd>
        </dl>
      </div>
    </xsl:if>

    <xsl:if test="db:bibliomisc[@role='namespace']">
      <div class="namespaces">
	<dl>
	  <dt class="loc-heading">
	    <xsl:text>Declared XML Namespace:</xsl:text>
	    <xsl:if test="count(db:bibliomisc[@role='namespace']) &gt; 1">s</xsl:if>
	  </dt>
	  <xsl:for-each select="db:bibliomisc[@role='namespace']">
	    <dd>
              <p>
                <a href="{.}">
                  <xsl:value-of select="."/>
                </a>
              </p>
	    </dd>
	  </xsl:for-each>
	</dl>
      </div>
    </xsl:if>

    <dl>
      <dt class="loc-heading">Abstract:</dt>
      <dd>
        <xsl:apply-templates select="db:abstract"/>
      </dd>
    </dl>

    <dl>
      <dt class="loc-heading">Status:</dt>
      <dd>
        <xsl:apply-templates select="db:legalnotice[@role='status']"/>
      </dd>
    </dl>

    <dl>
      <dt class="loc-heading">Notices:</dt>
      <dd>
        <xsl:apply-templates select="db:legalnotice[@role='notices']"/>
      </dd>
    </dl>
  </div>
</xsl:template>

<xsl:template match="db:editor|db:editor|db:othercredit" mode="spec.titlepage">
  <dd>
    <xsl:apply-templates select="db:personname" mode="spec.titlepage"/>
    <xsl:if test="db:affiliation/db:orgname">
      <xsl:text>, </xsl:text>
      <span class="affiliation">
	<xsl:apply-templates select="db:affiliation/db:orgname"/>
      </span>
    </xsl:if>
    <xsl:if test="db:email">
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="db:email"/>
    </xsl:if>
  </dd>
</xsl:template>

<xsl:template match="db:personname" mode="spec.titlepage">
  <span class="personname">
    <xsl:apply-templates select="db:firstname"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="db:surname"/>
  </span>
</xsl:template>

<xsl:template match="db:abstract|db:legalnotice">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="db:section/db:info/db:title" mode="m:titlepage-mode">
  <xsl:variable name="depth"
		select="count(ancestor::db:section)"/>

  <xsl:variable name="hslevel"
		select="if ($depth &lt; 4) then $depth else 3"/>

  <xsl:variable name="hlevel"
		select="if (ancestor::db:appendix) then $hslevel+2 else $hslevel+1"/>

  <xsl:element name="h{$hlevel}" namespace="http://www.w3.org/1999/xhtml">
    <xsl:attribute name="class" select="'title'"/>
    <xsl:apply-templates select="../.." mode="m:object-title-markup">
      <xsl:with-param name="allow-anchors" select="1"/>
    </xsl:apply-templates>
  </xsl:element>
</xsl:template>

<xsl:template match="db:appendix/db:info/db:title"
	      mode="m:titlepage-mode"
	      priority="100">
  <xsl:variable name="title" as="element()">
    <xsl:next-match/>
  </xsl:variable>

  <h2>
    <xsl:copy-of select="$title/node()"/>
    <xsl:if test="../../@role='non-normative'">
      <xsl:text> (Non-Normative)</xsl:text>
    </xsl:if>
  </h2>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:phrase[@revisionflag]">
  <span class="rev-{@revisionflag}">
    <xsl:next-match/>
  </span>
</xsl:template>

</xsl:stylesheet>

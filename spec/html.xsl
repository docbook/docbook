<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:t="http://docbook.org/xslt/ns/template"
	        xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="db t xlink"
                version="2.0">

<xsl:import href="/projects/docbook/xslt20/xslt/base/html/final-pass.xsl"/>

<xsl:param name="dateTime-format" select="'[D1] [MNn,*-3] [Y0001]'"/>

<xsl:param name="generate.toc" as="element()*"
           xmlns="http://docbook.org/ns/docbook">
<tocparam path="appendix" toc="0" title="1"/>
<tocparam path="article" toc="1" title="1"/>
</xsl:param>

<xsl:template name="t:css">
  <xsl:param name="node" select="."/>
  <link rel="stylesheet" href="http://docs.oasis-open.org/templates/DocBook/spec-0.6/css/oasis-spec.css" type="text/css" />
  <style type="text/css">
ul.toc {
    list-style-type: none;
    padding-left: 0px;
    margin-top: 0.25em;
    margin-bottom: 0.25em;
}

ul.toc
ul.toc {
    padding-left: 1.5em;
}

ul.toc a,
ul.toc a:visited {
    text-decoration: none;
}
  </style>
</xsl:template>

<!-- ====================================================================== -->

<xsl:template match="db:article">
  <article>
    <xsl:apply-templates/>
    <xsl:if test="not(parent::db:article)">
      <xsl:call-template name="t:process-footnotes"/>
    </xsl:if>
  </article>
</xsl:template>

<xsl:template match="db:article/db:info">
  <div class="titlepage">
    <div>
      <p class="logo"><a href="http://www.oasis-open.org/"><img src="http://docs.oasis-open.org/templates/DocBook/spec-0.6/OASISLogo.jpg" alt="OASIS" /></a>
      </p>

      <div>
        <hr style="margin-bottom:0pt" />
        <h1 class="title">
          <xsl:apply-templates select="db:title/node()"/>
        </h1>
      </div>

      <div>
        <h2>
          <xsl:value-of select="db:releaseinfo[@role='stage']"/>
          <xsl:text> Draft </xsl:text>
          <xsl:value-of select="db:biblioid[@role='pubsnumber']"/>
        </h2>
        <h2>
          <xsl:apply-templates select="db:pubdate"/>
        </h2>
      </div>

      <div>
        <dl>
          <dt><span class="loc-heading">Specification URIs:</span></dt>
        </dl>
        <dl>
          <dt><span class="loc-heading">This Version:</span></dt>
          <dd>
            <a href="{db:releaseinfo[@role='root']}/{db:productnumber}{db:biblioid[@class='pubsnumber']}/{db:productname}-v5.1-{db:productnumber}{db:biblioid[@class='pubsnumber']}.html">
              <xsl:value-of select="db:releaseinfo[@role='root']"/>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="db:productnumber"/>
              <xsl:value-of select="db:biblioid[@class='pubsnumber']"/>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="db:productname"/>
              <xsl:text>-v5.1-</xsl:text>
              <xsl:value-of select="db:productnumber"/>
              <xsl:value-of select="db:biblioid[@class='pubsnumber']"/>
              <xsl:text>.html</xsl:text>
            </a>
            (Authoritative)
          </dd>
        </dl>
        <dl>
          <dt><span class="loc-heading">Previous Version:</span></dt>
          <dd>None</dd>
        </dl>
        <dl>
          <dt><span class="loc-heading">Latest Version:</span></dt>
          <dd>
            <a href="{db:releaseinfo[@role='root']}/{db:productname}-v5.1.html">
              <xsl:value-of select="db:releaseinfo[@role='root']"/>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="db:productname"/>
              <xsl:text>-v5.1.html</xsl:text>
            </a>
            (Authoritative)
          </dd>
        </dl>
      </div>

      <div>
        <dl>
          <dt><span class="loc-heading">Technical Committee:</span></dt>
          <dd>
            <a href="{db:org/db:orgdiv/@xlink:href}">
              <xsl:value-of select="db:org/db:orgdiv"/>
            </a>
          </dd>
        </dl>
      </div>

      <div>
        <dl>
          <dt><span class="contrib-heading">Chair:</span></dt>
          <dd>
            <xsl:apply-templates select="db:othercredit[@otherclass='chair']"/>
          </dd>
        </dl>
        <dl>
          <dt><span class="editor-heading">Editor:</span></dt>
          <dd>
            <xsl:apply-templates select="db:authorgroup/db:editor"/>
          </dd>
        </dl>
      </div>

      <div>
        <dl>
          <dt><span class="status-heading">Additional artifacts:</span></dt>
          <dd>
            <p>This prose specification is one component of a Work Product that
               also includes:</p>
          <ul>
            <xsl:apply-templates
                 select="db:bibliorelation[@othertype='workproduct']"/>
         </ul>
         </dd>
       </dl>
      </div>

      <div>
        <dl>
          <dt><span class="status-heading">Related Work:</span></dt>
          <dd>
            <p>This specification replaces or supersedes:</p>
            <div class="itemizedlist">
              <ul>
                <li>
                  <cite>The DocBook Schema Version 5.0</cite>.
                  1 November 2009.
                  OASIS Standard.
                  <a href="http://docbook.org/specs/docbook-5.0-spec-os.html">http://docbook.org/specs/docbook-5.0-spec-os.html</a>
                </li>
              </ul>
            </div>
          </dd>
        </dl>
      </div>

      <div>
        <dl>
          <dt><span class="status-heading">Declared XML Namespaces:</span></dt>
          <dd>
            <p><a href="http://docbook.org/ns/docbook" target="_top">http://docbook.org/ns/docbook</a></p>
          </dd>
        </dl>
      </div>
      <div>
        <dl>
          <dt><span class="abstract-heading">Abstract:</span></dt>
          <dd>
            <xsl:apply-templates select="db:abstract/node()"/>
          </dd>
        </dl>
      </div>

      <div>
        <xsl:apply-templates select="db:legalnotice[@role='status']"/>
      </div>

      <div>
        <dl>
          <dt><span class="status-heading">Citation format:</span></dt>
          <dd><p>When referencing this specification, the following citation
          format should be used:</p>
<p>[DocBook 5.1] <cite>DocBook Version 5.1</cite>.
<xsl:apply-templates select="db:pubdate"/>.
OASIS <xsl:value-of select="db:releaseinfo[@role='stage']"/>
Draft <xsl:value-of select="db:biblioid[@class='pubsnumber']"/>.
            <a href="{db:releaseinfo[@role='root']}/{db:productnumber}{db:biblioid[@class='pubsnumber']}/{db:productname}-v5.1-{db:productnumber}{db:biblioid[@class='pubsnumber']}.html">
              <xsl:value-of select="db:releaseinfo[@role='root']"/>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="db:productnumber"/>
              <xsl:value-of select="db:biblioid[@class='pubsnumber']"/>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="db:productname"/>
              <xsl:text>-v5.1-</xsl:text>
              <xsl:value-of select="db:productnumber"/>
              <xsl:value-of select="db:biblioid[@class='pubsnumber']"/>
              <xsl:text>.html</xsl:text>
            </a></p>
          </dd>
        </dl>
      </div>
    </div>
  </div>

  <xsl:apply-templates select="db:legalnotice[@role='notices']"/>
</xsl:template>

<xsl:template match="processing-instruction('pubver')">
  <xsl:text>V5.1-</xsl:text>
  <xsl:value-of select="/db:article/db:info/db:productnumber"/>
  <xsl:value-of select="/db:article/db:info/db:biblioid[@class='pubsnumber']"/>
</xsl:template>

<xsl:template match="db:legalnotice[@role='status']">
  <dl>
    <dt><span class="status-heading">Status:</span></dt>
    <dd>
      <xsl:apply-templates/>
    </dd>
  </dl>
</xsl:template>

<xsl:template match="db:legalnotice[@role='notices']">
  <div>
    <hr />
    <h2 class="notices-heading">Notices</h2>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="db:othercredit|db:editor">
  <xsl:apply-templates select="db:personname"/>
  <xsl:apply-templates select="db:email" mode="info"/>
  <xsl:apply-templates select="db:affiliation" mode="info"/>
</xsl:template>

<xsl:template match="db:email" mode="info">
  <xsl:text> (</xsl:text>
  <a href="mailto:{.}">
    <xsl:value-of select="."/>
  </a>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="db:affiliation" mode="info">
  <xsl:text>, </xsl:text>
  <xsl:apply-templates select="db:orgname,db:org" mode="info"/>
  <xsl:text></xsl:text>
</xsl:template>

<xsl:template match="db:orgname" mode="info">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="db:org" mode="info">
  <xsl:choose>
    <xsl:when test="db:uri">
      <a href="{db:uri}">
        <xsl:apply-templates select="db:orgname" mode="info"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="db:orgname" mode="info"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="db:bibliorelation[@othertype='workproduct']">
  <xsl:variable name="info" select="ancestor::db:info"/>
  <li>
    <xsl:value-of select="@xlink:title"/>
    <xsl:text> accessible from </xsl:text>
    <a href="{$info/db:releaseinfo[@role='root']}/{$info/db:productnumber}{$info/db:biblioid[@class='pubsnumber']}/{@xlink:href}">
      <xsl:value-of select="$info/db:releaseinfo[@role='root']"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$info/db:productnumber"/>
      <xsl:value-of select="$info/db:biblioid[@class='pubsnumber']"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="@xlink:href"/>
    </a>
  </li>
</xsl:template>

<xsl:template name="t:format-toc-title">
  <xsl:param name="toc-context" as="element()"/>
  <xsl:param name="toc-title" as="node()*"/>
  <hr/>
  <h2>
    <xsl:sequence select="$toc-title"/>
  </h2>
</xsl:template>

</xsl:stylesheet>

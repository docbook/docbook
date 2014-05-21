<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:t="http://docbook.org/xslt/ns/template"
	        xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="db t xlink"
                version="2.0">

<xsl:import href="/projects/docbook/xslt20/xslt/base/html/docbook.xsl"/>

<xsl:template name="t:css">
  <xsl:param name="node" select="."/>
  <link rel="stylesheet" href="http://docs.oasis-open.org/templates/DocBook/spec-0.5/css/oasis-spec.css" type="text/css" />
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
      <p class="logo"><a href="http://www.oasis-open.org/"><img src="http://docs.oasis-open.org/templates/DocBook/spec-0.5/OASISLogo.jpg" alt="OASIS" border="0" /></a></p>
      <div>
        <h1 class="title">
          <xsl:apply-templates select="db:title/node()"/>
        </h1>
      </div>

      <div>
        <h2>Technical Committee Editorial Draft Candidate Release 2 (CR2)</h2>
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
          <dd>…</dd>
        </dl>
        <dl>
          <dt><span class="loc-heading">Previous Version:</span></dt>
          <dd>None</dd>
        </dl>
        <dl>
          <dt><span class="loc-heading">Latest Version:</span></dt>
          <dd>…</dd>
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
          <dt><span class="contrib-heading">Chairs:</span></dt>
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
<!--
      <div>
        <dl>
          <dt><span class="status-heading">Related Work:</span></dt>
          <dd>
            <p>This specification replaces or supersedes:</p>
            <div class="itemizedlist">
              <ul type="disc" compact="compact">
                <li>
                  <p>{specification replaced by this standard}</p>
                </li>
                <li>
                  <p>{specification replaced by this standard}</p>
                </li>
              </ul>
            </div>
            <p>This specification is related to:</p>
            <div class="itemizedlist">
              <ul type="disc" compact="compact">
                <li>
                  <p>{related specifications}</p>
                </li>
                <li>
                  <p>{related specifications}</p>
                </li>
              </ul>
            </div>
          </dd>
        </dl>
      </div>
-->
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
        <dl>
          <dt><span class="status-heading">Status:</span></dt>
          <dd>
<p>This document was last revised or approved by the DocBook
Technical Committee on the above date. The level of approval is also
listed above. Check the current location noted above for possible
later revisions of this document. This document is updated
periodically on no particular schedule.</p>

<p>Technical Committee members should send comments on this
specification to the Technical Committee's email list. Others should
send comments to the Technical Committee by using the "Send A Comment"
button on the Technical Committee's web page at <a
href="http://www.oasis-open.org/committees/docbook"
target="_top">http://www.oasis-open.org/committees/docbook</a>.</p>

<p>For information on whether any patents have been disclosed that may
be essential to implementing this specification, and any offers of
patent licensing terms, please refer to the Intellectual Property
Rights section of the Technical Committee web page (<a
href="http://www.oasis-open.org/committees/docbook/ipr.php"
target="_top">http://www.oasis-open.org/committees/docbook/ipr.php</a>).</p>

<p>The non-normative errata page for this specification is located at
<a href="http://www.oasis-open.org/committees/docbook"
target="_top">http://www.oasis-open.org/committees/docbook</a>.</p>
          </dd>
        </dl>
      </div>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>

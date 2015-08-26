<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                name="main">
<p:input port="source"/>

<p:option name="pdf" required="true"/>
<p:option name="docid" required="true"/>

<p:declare-step type="cx:css-formatter">
     <p:input port="source" primary="true"/>
     <p:input port="css" sequence="true"/>
     <p:input port="parameters" kind="parameter"/>
     <p:output port="result" primary="false"/>
     <p:option name="href" required="true"/>
     <p:option name="content-type"/>
</p:declare-step>

<p:xslt name="xslt">
  <p:input port="source">
    <p:inline>
      <c:result>/* Print overrides */
@media print {
  body {
     margin-left: 0pc!important;
  }
  div.toc { break-before: page }
  div.notices { break-before: page }
  div.bibliomixed { page-break-inside: avoid; }

  .toc a::after {
    content: " " leader(dotted) " " target-counter(attr(href, url), page);
  }
}

@page {
  margin-top: 1in;
  margin-bottom: 1in;
  margin-left: 1in;
  margin-right: 1in;


  @bottom-left {
    content: "@@DOCID@@\aStandards Track Work Product";
    font-family: sans-serif;
    font-size: 8pt;
    padding-bottom: 2em;
    vertical-align: bottom;
    white-space: pre;
  }

  @bottom-center {
    content: "Copyright © OASIS Open @@YEAR@@. All Rights Reserved.";
    font-family: sans-serif;
    font-size: 8pt;
    padding-bottom: 2em;
    vertical-align: bottom;
    white-space: pre;
  }

  @bottom-right {
    content: "@@DATE@@\aPage " counter(page) " of " counter(pages);
    font-family: sans-serif;
    font-size: 8pt;
    padding-bottom: 2em;
    vertical-align: bottom;
    white-space: pre;
  }
}
      </c:result>
    </p:inline>
  </p:input>
  <p:input port="stylesheet">
    <p:inline>
      <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                      xmlns:xs="http://www.w3.org/2001/XMLSchema"
                      xmlns:c="http://www.w3.org/ns/xproc-step"
		      exclude-result-prefixes="xs"
                      version="2.0">

        <xsl:param name="docid" required="yes"/>

        <xsl:template match="element()">
          <xsl:copy>
            <xsl:apply-templates select="@*,node()"/>
          </xsl:copy>
        </xsl:template>

        <xsl:template match="attribute()|comment()|processing-instruction()">
          <xsl:copy/>
        </xsl:template>

        <xsl:template match="text()">
          <xsl:variable name="year"
                        select="format-date(current-date(), '[Y0001]')"/>
          <xsl:variable name="date"
                        select="format-date(current-date(),
			                    '[D01] [MNn] [Y0001]')"/>

          <xsl:variable name="docid"
                        select="replace(., '@@DOCID@@', $docid)"/>
          <xsl:variable name="year"
                        select="replace($docid, '@@YEAR@@', $year)"/>
          <xsl:variable name="dated"
                        select="replace($year, '@@DATE@@', $date)"/>

          <xsl:value-of select="$dated"/>
        </xsl:template>

      </xsl:stylesheet>
    </p:inline>
  </p:input>
  <p:log port="result" href="/tmp/out.xml"/>
  <p:with-param name="docid" select="$docid"/>
</p:xslt>

<cx:css-formatter name="css">
  <p:input port="source">
    <p:pipe step="main" port="source"/>
  </p:input>
  <p:input port="css">
    <p:pipe step="xslt" port="result"/>
  </p:input>
  <p:input port="parameters">
    <p:empty/>
  </p:input>
  <p:with-option name="href" select="resolve-uri($pdf, base-uri(/))">
    <p:pipe step="main" port="source"/>
  </p:with-option>
</cx:css-formatter>

</p:declare-step>

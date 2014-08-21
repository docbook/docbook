<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>
<p:serialization port="result" method="text"/>

<p:option name="schema" required="true"/>

<p:declare-step type="cx:message">
   <p:input port="source" sequence="true"/>
   <p:output port="result" sequence="true"/>
   <p:option name="message" required="true"/>
</p:declare-step>

<p:try name="validate">
  <p:group>
    <p:output port="result"/>

    <p:choose>
      <p:when test="p:system-property('p:psvi-supported') = 'true'">
        <p:load name="xsd">
          <p:with-option name="href"
                         select="resolve-uri($schema, exf:cwd())"/>
        </p:load>

        <p:validate-with-xml-schema cx:version="1.1">
          <p:input port="source">
            <p:pipe step="main" port="source"/>
          </p:input>
          <p:input port="schema">
            <p:pipe step="xsd" port="result"/>
          </p:input>
        </p:validate-with-xml-schema>
      </p:when>
      <p:otherwise>
        <cx:message name="message"
                    message="XSD validation unavailable: ">
          <p:input port="source">
            <p:pipe step="main" port="source"/>
          </p:input>
        </cx:message>
        <p:error code="c:NOXSDVAL">
          <p:input port="source">
            <p:pipe step="message" port="result"/>
          </p:input>
        </p:error>
      </p:otherwise>
    </p:choose>
    <p:xslt>
      <p:input port="stylesheet">
        <p:inline>
          <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                          version="2.0">
            <xsl:output method="xml"/>
            <xsl:template match="/">
              <result>FAIL&#10;</result>
            </xsl:template>
          </xsl:stylesheet>
        </p:inline>
      </p:input>
    </p:xslt>
  </p:group>
  <p:catch>
    <p:output port="result"/>

    <p:xslt>
      <p:input port="source"><p:inline><doc/></p:inline></p:input>
      <p:input port="stylesheet">
        <p:inline>
          <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                          version="2.0">
            <xsl:output method="xml"/>
            <xsl:template match="/">
              <result>PASS&#10;</result>
            </xsl:template>
          </xsl:stylesheet>
        </p:inline>
      </p:input>
    </p:xslt>
  </p:catch>
</p:try>

<p:choose>
  <p:when test="starts-with(/*, 'FAIL')">
    <p:error code="c:FAIL">
      <p:input port="source">
        <p:pipe step="validate" port="result"/>
      </p:input>
    </p:error>
  </p:when>
  <p:otherwise>
    <p:identity/>
  </p:otherwise>
</p:choose>

</p:declare-step>

<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:exf="http://exproc.org/standard/functions"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>
<p:serialization port="result" method="text"/>

<p:option name="schema" required="true"/>

<p:load name="load-rng">
  <p:with-option name="href"
                 select="concat(resolve-uri($schema, exf:cwd()),'.rng')"/>
</p:load>

<p:load name="load-sch">
  <p:with-option name="href"
                 select="concat(resolve-uri($schema, exf:cwd()),'.sch')"/>
</p:load>

<p:try name="validate">
  <p:group>
    <p:output port="result"/>

    <p:validate-with-relax-ng>
      <p:input port="source">
        <p:pipe step="main" port="source"/>
      </p:input>
      <p:input port="schema">
        <p:pipe step="load-rng" port="result"/>
      </p:input>
    </p:validate-with-relax-ng>

    <p:validate-with-schematron name="sch">
      <p:input port="schema">
        <p:pipe step="load-sch" port="result"/>
      </p:input>
    </p:validate-with-schematron>

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

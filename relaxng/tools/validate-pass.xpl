<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>
<p:serialization port="result" method="text"/>

<p:option name="schema" required="true"/>

<p:load name="rng">
  <p:with-option name="href"
                 select="concat(resolve-uri($schema, exf:cwd()),'.rng')"/>
</p:load>

<p:load name="sch">
  <p:with-option name="href"
                 select="concat(resolve-uri($schema, exf:cwd()),'.sch')"/>
</p:load>

<p:validate-with-relax-ng>
  <p:input port="source">
    <p:pipe step="main" port="source"/>
  </p:input>
  <p:input port="schema">
    <p:pipe step="rng" port="result"/>
  </p:input>
</p:validate-with-relax-ng>

<p:validate-with-schematron>
  <p:input port="schema">
    <p:pipe step="sch" port="result"/>
  </p:input>
</p:validate-with-schematron>

<p:xslt>
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

</p:declare-step>

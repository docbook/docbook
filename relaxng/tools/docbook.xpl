<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>

<p:option name="xinclude" select="'true'"/>
<p:option name="schema" select="'docbook'"/>
<p:option name="schematron" select="'docbook'"/>

<p:choose name="doc">
  <p:when test="$xinclude = 'true'">
    <p:output port="result"/>
    <p:xinclude/>
  </p:when>
  <p:otherwise>
    <p:output port="result"/>
    <p:identity/>
  </p:otherwise>
</p:choose>

<p:choose name="rngschema">
  <p:when test="not(contains($schema, '.'))">
    <p:output port="result"/>
    <p:load>
      <p:with-option name="href" select="concat($schema, '.rng')"/>
    </p:load>
  </p:when>
  <p:otherwise>
    <p:output port="result"/>
    <p:load>
      <p:with-option name="href" select="resolve-uri($schema, exf:cwd())"/>
    </p:load>
  </p:otherwise>
</p:choose>

<p:validate-with-relax-ng name="rngvalid">
  <p:input port="source">
    <p:pipe step="doc" port="result"/>
  </p:input>
  <p:input port="schema">
    <p:pipe step="rngschema" port="result"/>
  </p:input>
</p:validate-with-relax-ng>

<p:choose>
  <p:when test="$schematron = ''">
    <p:output port="result"/>
    <p:identity/>
  </p:when>
  <p:otherwise>
    <p:output port="result"/>
    <p:choose name="schschema">
      <p:when test="not(contains($schematron, '.'))">
        <p:output port="result"/>
        <p:load>
          <p:with-option name="href" select="concat($schematron, '.sch')"/>
        </p:load>
      </p:when>
      <p:otherwise>
        <p:output port="result"/>
        <p:load>
          <p:with-option name="href" select="resolve-uri($schema, exf:cwd())"/>
        </p:load>
      </p:otherwise>
    </p:choose>

    <p:validate-with-schematron>
      <p:input port="source">
        <p:pipe step="rngvalid" port="result"/>
      </p:input>
      <p:input port="schema">
        <p:pipe step="schschema" port="result"/>
      </p:input>
    </p:validate-with-schematron>
  </p:otherwise>
</p:choose>

</p:declare-step>

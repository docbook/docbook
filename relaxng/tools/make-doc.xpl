<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="parameters" kind="parameter"/>
<p:option name="schema" required="true"/>

<p:exec command="java" source-is-xml='false' result-is-xml='false' name="trang">
  <p:input port="source">
    <p:empty/>
  </p:input>
  <p:with-option name="args" select="concat('-jar ../../lib/trang-2009-11-11.jar ', $schema,'/',$schema,'.rnc build/',$schema,'/',$schema,'.rng')">
    <p:empty/>
  </p:with-option>
</p:exec>

<p:sink/>

<p:load cx:depends-on="trang">
  <p:with-option name="href" select="concat('../schemas/build/', $schema, '/', $schema, '.rng')"/>
</p:load>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="include.xsl"/>
  </p:input>
</p:xslt>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="augment.xsl"/>
  </p:input>
</p:xslt>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="cleanup.xsl"/>
  </p:input>
</p:xslt>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="rngdocxml.xsl"/>
  </p:input>
</p:xslt>

<p:store name="store" method="xml" indent="true">
  <p:with-option name="href" select="concat('../schemas/', $schema, '.rnd')"/>
</p:store>

</p:declare-step>

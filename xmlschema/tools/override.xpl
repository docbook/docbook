<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>
<p:serialization port="result" indent="true"/>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="overincl.xsl"/>
  </p:input>
</p:xslt>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="overexpd.xsl"/>
  </p:input>
</p:xslt>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="overdel.xsl"/>
  </p:input>
</p:xslt>

</p:declare-step>

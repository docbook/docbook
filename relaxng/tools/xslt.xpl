<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:input port="stylesheet"/>
<p:output port="result"/>
<p:serialization port="result" indent="false" method="xml"/>

<p:xslt>
  <p:input port="source">
    <p:pipe step="main" port="source"/>
  </p:input>
  <p:input port="stylesheet">
    <p:pipe step="main" port="stylesheet"/>
  </p:input>
</p:xslt>

</p:declare-step>

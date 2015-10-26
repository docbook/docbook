<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>

<p:option name="version" required="true"/>
<p:option name="tdg" required="true"/>
<p:option name="tdgtitle" select="0"/>

<p:serialization port="result" version="5" method="html"/>

<p:template>
  <p:input port="template">
    <p:pipe step="main" port="source"/>
  </p:input>
  <p:with-param name="version" select="$version"/>
  <p:with-param name="tdg" select="$tdg"/>
  <p:with-param name="tdgtitle" select="$tdgtitle"/>
</p:template>

</p:declare-step>

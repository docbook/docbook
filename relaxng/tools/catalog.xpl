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

<p:option name="ROOT" required="true"/>
<p:option name="VERSION" required="true"/>
<p:option name="RELEASE" select="'ERROR'"/>
<p:option name="ROOT2" select="'ERROR'"/>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="catalog.xsl"/>
  </p:input>
  <p:with-param name="ROOT" select="$ROOT"/>
  <p:with-param name="VERSION" select="$VERSION"/>
  <p:with-param name="RELEASE" select="$RELEASE"/>
  <p:with-param name="ROOT2" select="$ROOT2"/>
</p:xslt>

</p:declare-step>

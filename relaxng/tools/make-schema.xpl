<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="parameters" kind="parameter"/>
<p:option name="schema" required="true"/>
<p:option name="release" required="true"/>
<p:option name="remove-schematron" select="0"/>
<p:option name="make-rnc" select="'1'"/>

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
  <p:with-option name="href" select="concat(exf:cwd(),'/build/', $schema, '/', $schema, '.rng')"/>
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

<p:xslt name="schema">
  <p:input port="stylesheet">
    <p:document href="removedoc.xsl"/>
  </p:input>
  <p:with-param name="remove-schematron" select="$remove-schematron"/>
</p:xslt>

<p:load name="copyright-template">
  <p:with-option name="href" select="concat(exf:cwd(), '/', $schema, '/copyright.xml')"/>
</p:load>

<p:template name="copyright">
  <p:input port="template">
    <p:pipe step="copyright-template" port="result"/>
  </p:input>
  <p:with-param name="release" select="$release"/>
</p:template>

<p:xslt name="final">
  <p:input port="source">
    <p:pipe step="schema" port="result"/>
  </p:input>
  <p:input port="stylesheet">
    <p:document href="attach-copyright.xsl"/>
  </p:input>
  <p:with-param name="copyright" select="/*">
    <p:pipe step="copyright" port="result"/>
  </p:with-param>
</p:xslt>

<p:store name="store" method="xml" indent="true">
  <p:with-option name="href" select="concat(exf:cwd(), '/', $schema, '.rng')"/>
</p:store>

<!-- Store it without indentation so that trang doesn't put a whole bunch
     of ugly, spurious whitespace nodes in the Schematron rules. -->
<p:store name="store-fixws" method="xml" indent="false">
  <p:input port="source">
    <p:pipe step="final" port="result"/>
  </p:input>
  <p:with-option name="href"
                 select="concat(exf:cwd(), '/build/', $schema, '-ws.rng')"/>
</p:store>

<p:choose>
  <p:when test="$make-rnc != '0'">
    <p:exec command="java" source-is-xml='false' result-is-xml='false'
            cx:depends-on="store-fixws">
      <p:input port="source">
        <p:empty/>
      </p:input>
      <p:with-option name="args"
         select="concat('-jar ../../lib/trang-2009-11-11.jar build/', $schema,'-ws.rng ',$schema,'.rnc')">
        <p:empty/>
      </p:with-option>
    </p:exec>
    <p:sink/>
  </p:when>
  <p:otherwise>
    <p:sink>
      <p:input port="source">
        <p:empty/>
      </p:input>
    </p:sink>
  </p:otherwise>
</p:choose>

</p:declare-step>

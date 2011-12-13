<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main" type="cx:validate">
<p:input port="source" primary="true"/>
<p:input port="schema"/>
<p:input port="schematron" sequence="true"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>
<p:serialization port="result" indent="true"/>

<p:validate-with-xml-schema name="xsdvalid">
  <p:input port="schema">
    <p:pipe step="main" port="schema"/>
  </p:input>
</p:validate-with-xml-schema>

<p:count>
  <p:input port="source">
    <p:pipe step="main" port="schematron"/>
  </p:input>
</p:count>

<p:choose>
  <p:when test="/c:result = 1">
    <p:try>
      <p:group>
        <p:validate-with-schematron name="sch">
          <p:input port="source">
            <p:pipe step="xsdvalid" port="result"/>
          </p:input>
          <p:input port="schema">
            <p:pipe step="main" port="schematron"/>
          </p:input>
        </p:validate-with-schematron>
      </p:group>
      <p:catch>
        <p:validate-with-schematron name="sch" assert-valid="false">
          <p:input port="source">
            <p:pipe step="xsdvalid" port="result"/>
          </p:input>
          <p:input port="schema">
            <p:pipe step="main" port="schematron"/>
          </p:input>
        </p:validate-with-schematron>
        <p:sink/>
        <p:identity>
          <p:input port="source">
            <p:pipe step="sch" port="report"/>
          </p:input>
        </p:identity>
      </p:catch>
    </p:try>
  </p:when>
  <p:when test="/c:result = 0">
    <p:identity>
      <p:input port="source">
        <p:pipe step="xsdvalid" port="result"/>
      </p:input>
    </p:identity>
  </p:when>
  <p:otherwise>
    <p:error code="c:XXX"/>
  </p:otherwise>
</p:choose>

</p:declare-step>

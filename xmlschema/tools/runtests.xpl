<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="schema">
  <p:document href="../schemas/docbook/docbook.xsd"/>
</p:input>
<p:input port="schematron" sequence="true"/>
<p:input port="parameters" kind="parameter"/>
<!--
<p:output port="result"/>
<p:serialization port="result" indent="true"/>
-->

<p:import href="validate.xpl"/>

<p:declare-step type="cx:message">
  <p:input port="source" sequence="true"/>
  <p:output port="result" sequence="true"/>
  <p:option name="message" required="true"/>
</p:declare-step>

<p:directory-list path="../../../xslt20/tests/xspec/src" include-filter="^.*\.xml$"/>

<!-- These tests are not valid DocBook markup, so we exclude them -->
<p:delete match="c:file[@name='calloutlist.003.xml']"/>

<!-- This test relies on xml:id being recognized on non-DocBook elements -->
<p:delete match="c:file[@name='xref.002.xml']"/>

<!-- These tests are not valid DocBook 5.0 markup, so we exclude them -->
<p:delete match="c:file[@name='inlines.001.xml']"/>
<p:delete match="c:file[@name='xlink.001.xml']"/>

<p:make-absolute-uris match="c:file/@name"/>

<p:for-each name="loop">
  <p:iteration-source select="/c:directory/c:file"/>

  <p:load>
    <p:with-option name="href" select="/c:file/@name"/>
  </p:load>

  <cx:message>
    <p:with-option name="message" select="concat('Validating: ', /c:file/@name)">
      <p:pipe step="loop" port="current"/>
    </p:with-option>
  </cx:message>

  <cx:validate>
    <p:input port="schema">
      <p:pipe step="main" port="schema"/>
    </p:input>
    <p:input port="schematron">
      <p:pipe step="main" port="schematron"/>
    </p:input>
  </cx:validate>

  <p:sink/>
</p:for-each>

</p:declare-step>

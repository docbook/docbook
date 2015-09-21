<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:px="http://docbook.org/pipelines"
                type="px:rng-to-rnc"
                name="main">
<p:option name="schema" required="true"/>

<p:exec command="java" source-is-xml='false' result-is-xml='false'>
  <p:input port="source">
    <p:empty/>
  </p:input>
  <p:with-option name="args" select="concat('-jar ../../lib/trang-2009-11-11.jar ', $schema,'.rng ',$schema,'.rnc')">
    <p:empty/>
  </p:with-option>
</p:exec>

<p:sink/>

</p:declare-step>

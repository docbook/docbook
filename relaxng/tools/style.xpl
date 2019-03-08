<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0" name="main">
<p:input port="source"/>
<p:input port="stylesheet"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result"/>

<p:xslt>
  <p:input port="source">
    <p:pipe step="main" port="source"/>
  </p:input>
  <p:input port="stylesheet">
    <p:pipe step="main" port="stylesheet"/>
  </p:input>
</p:xslt>

</p:declare-step>

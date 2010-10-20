<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:s="http://purl.oclc.org/dsdl/schematron"
                xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
                xmlns:dtx="http://nwalsh.com/ns/dtd-xml"
                xmlns:f="http://nwalsh.com/functions/dtd-xml"
                xmlns="http://nwalsh.com/ns/dtd-xml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="s a dtx xs f"
                version="2.0">

<xsl:include href="common.xsl"/>

<!-- If a zerorOrMore contains a zeroOrMore, unwrap it -->

<xsl:key name="ref" match="dtx:ref" use="@name"/>

<xsl:template match="dtx:zeroOrMore[parent::dtx:zeroOrMore]">
  <xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>

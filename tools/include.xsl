<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:ctrl="http://nwalsh.com/xmlns/schema-control/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="ctrl xs"
                version="2.0">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:key name="defs" match="rng:define" use="@name"/>
  <xsl:key name="refs" match="rng:ref" use="@name"/>
  <xsl:key name="combines" match="rng:define[@combine='choice']" use="@name"/>
  <xsl:key name="interleaves"
	   match="rng:define[@combine='interleave']"
	   use="@name"/>
  <xsl:key name="overrides" match="rng:define[@override]" use="@name"/>

  <xsl:variable name="debug" select="0"/>

  <xsl:template match="/">
    <xsl:variable name="expanded">
      <xsl:apply-templates mode="include"/>
    </xsl:variable>

    <xsl:variable name="conditional">
      <xsl:apply-templates select="$expanded/*"
			   mode="conditional"/>
    </xsl:variable>

    <xsl:variable name="overridden">
      <xsl:apply-templates select="$conditional/*"
			   mode="override"/>
    </xsl:variable>

    <xsl:variable name="combined">
      <xsl:apply-templates select="$overridden/*"
			   mode="combine"/>
    </xsl:variable>

    <xsl:variable name="withoutunused">
      <xsl:call-template name="removeunused">
	<xsl:with-param name="doc" select="$combined"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:copy-of select="$withoutunused"/>
  </xsl:template>

  <!-- ====================================================================== -->

  <xsl:template match="rng:grammar[@ns]" mode="include">
    <xsl:copy>
      <xsl:copy-of select="@* except @ns"/>
      <xsl:attribute name="ns">
        <xsl:choose>
          <xsl:when test="@ns = 'http://docbook.org/ns/docbook'
                          or @ns = 'http://www.w3.org/2005/11/its'">
            <xsl:sequence select="'http://docbook.org/ns/docbook'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="error((), concat('Unexpected @ns: ', @ns))"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates mode="include"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rng:include" mode="include">
    <xsl:variable name="doc" select="document(@href,.)"/>
    <xsl:variable name="nestedGrammar">
      <xsl:apply-templates select="$doc/rng:grammar/*" mode="include"/>
      <xsl:apply-templates mode="markOverride"/>
    </xsl:variable>

    <xsl:apply-templates select="$nestedGrammar/*"
			 mode="override"/>
    <xsl:if test="$debug != 0">
      <xsl:message>Included <xsl:value-of select="@href"/></xsl:message>
    </xsl:if>
  </xsl:template>

  <!-- This is a total hack. It works around the fact that my RNG flattening
       tools aren't really RNG-aware. Trang puts @ns="" on the xinclude.rng
       file, but I don't get that right when I flatten; so hack it. -->
  <xsl:template match="rng:nsName[not(@ns) and ancestor::rng:define[@name='db.any.other.attribute']]"
                mode="include">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="ns"></xsl:attribute>
      <xsl:apply-templates mode="include"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rng:element" mode="include">
    <xsl:variable name="ns"
                  select="ancestor::*[@ns][1]/@ns[. != 'http://docbook.org/ns/docbook']
                          /string()"/>
    <xsl:variable name="name" as="xs:string?">
      <xsl:choose>
        <xsl:when test="empty(@name)"/>
        <xsl:when test="empty($ns) or contains(@name, ':')">
          <xsl:sequence select="@name/string()"/>
        </xsl:when>
        <xsl:when test="$ns = 'http://www.w3.org/2005/11/its'">
          <xsl:sequence select="concat('its:', @name/string())"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="error((), concat('Unexpected ns: ', $ns))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:copy>
      <xsl:if test="exists($name)">
        <xsl:attribute name="name" select="$name"/>
      </xsl:if>
      <xsl:if test="exists($ns)">
        <xsl:attribute name="ns" select="$ns"/>
      </xsl:if>
      <xsl:copy-of select="@* except (@ns | @name)"/>
      <xsl:apply-templates mode="include"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*" mode="include">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="include"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="comment()|processing-instruction()|text()" mode="include">
    <xsl:copy/>
  </xsl:template>

  <!-- ====================================================================== -->

  <xsl:template match="rng:div" mode="markOverride">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="markOverride"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*" mode="markOverride">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:if test="(.|parent::rng:div)/parent::rng:include">
	<xsl:if test="not(self::rng:define) and not(self::rng:start)">
	  <xsl:message>
	    <xsl:text>Warning: only expecting rng:define children </xsl:text>
	    <xsl:text>of rng:include (got </xsl:text>
	    <xsl:value-of select="name(.)"/>
	    <xsl:text>)</xsl:text>
	  </xsl:message>
	</xsl:if>

	<xsl:if test="not(@combine)
		      or (@combine != 'choice' and @combine != 'interleave')">
          <xsl:if test="$debug != 0">
            <xsl:message>Adding override to <xsl:value-of select="@name"/></xsl:message>
          </xsl:if>
	  <xsl:attribute name="override">
	    <xsl:value-of select="ancestor::rng:include[1]/@href"/>
	  </xsl:attribute>
	</xsl:if>
      </xsl:if>
      <xsl:apply-templates mode="markOverride"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="comment()|processing-instruction()|text()" mode="markOverride">
    <xsl:copy/>
  </xsl:template>

  <!-- Copy over documentation elements in DocBook namespace -->
  <xsl:template match="db:*" mode="markOverride">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="markOverride"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- ====================================================================== -->

  <xsl:template match="rng:define" mode="combine">
    <xsl:choose>
      <xsl:when test="@combine = 'choice'"/>
      <xsl:when test="@combine = 'interleave'"/>
      <xsl:when test="@combine">
	<!-- what's this!? -->
	<xsl:message>
	  <xsl:text>Warning: unexpected combine on rng:define for </xsl:text>
	  <xsl:value-of select="@name"/>
	</xsl:message>
	<xsl:copy>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates mode="combine"/>
	</xsl:copy>
      </xsl:when>

      <xsl:otherwise>
	<xsl:variable name="choices" select="key('combines', @name)"/>
	<xsl:variable name="ileaves" select="key('interleaves', @name)"/>
	<xsl:choose>
	  <xsl:when test="$choices and $ileaves">
	    <xsl:message>
	      <xsl:text>Warning: choice and interleave for </xsl:text>
	      <xsl:value-of select="@name"/>
	    </xsl:message>
	  </xsl:when>
	  <xsl:when test="$ileaves">
	    <!-- these are always attributes, right? -->
            <xsl:if test="$debug != 0">
              <xsl:message>
                <xsl:text>Interleaving definitions for </xsl:text>
                <xsl:value-of select="@name"/>
              </xsl:message>
            </xsl:if>

	    <xsl:if test="not(rng:interleave) or count(*) &gt; 1">
	      <xsl:message>
		<xsl:text>Unexpected content for </xsl:text>
		<xsl:value-of select="@name"/>
	      </xsl:message>
	    </xsl:if>

	    <xsl:copy>
	      <xsl:copy-of select="@*"/>
	      <rng:interleave>
		<xsl:apply-templates select="rng:interleave/*" mode="combine"/>
		<xsl:apply-templates select="$ileaves/*" mode="combine"/>
	      </rng:interleave>
	    </xsl:copy>
	  </xsl:when>
	  <xsl:when test="$choices">
            <xsl:if test="$debug != 0">
              <xsl:message>
                <xsl:text>Combining definitions for </xsl:text>
                <xsl:value-of select="@name"/>
              </xsl:message>
            </xsl:if>

	    <xsl:copy>
	      <xsl:copy-of select="@*"/>
	      <rng:choice>
		<xsl:apply-templates mode="combine"/>
		<xsl:for-each select="$choices">
		  <xsl:choose>
		    <xsl:when test="count(*) &gt; 1">
		      <!-- implicit group -->
		      <rng:group>
			<xsl:apply-templates select="*" mode="combine"/>
		      </rng:group>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:apply-templates select="*" mode="combine"/>
		    </xsl:otherwise>
		  </xsl:choose>
		</xsl:for-each>
	      </rng:choice>
	    </xsl:copy>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:copy>
	      <xsl:copy-of select="@*"/>
	      <xsl:apply-templates mode="combine"/>
	    </xsl:copy>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="rng:start" mode="combine">
    <xsl:choose>
      <xsl:when test="@combine = 'choice'"/>
      <xsl:when test="@combine">
	<!-- what's this!? -->
	<xsl:message>
	  <xsl:text>Warning: unexpected combine on rng:start</xsl:text>
	</xsl:message>
	<xsl:copy>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates mode="combine"/>
	</xsl:copy>
      </xsl:when>
      <xsl:otherwise>
	<xsl:variable name="choices" select="//rng:start[@combine='choice']"/>
	<xsl:choose>
	  <xsl:when test="$choices">
            <xsl:if test="$debug != 0">
              <xsl:message>
                <xsl:text>Combining start definitions</xsl:text>
              </xsl:message>
            </xsl:if>

	    <xsl:copy>
	      <xsl:copy-of select="@*"/>
	      <rng:choice>
		<xsl:apply-templates mode="combine"/>
		<xsl:apply-templates select="$choices/*" mode="combine"/>
	      </rng:choice>
	    </xsl:copy>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:copy>
	      <xsl:copy-of select="@*"/>
	      <xsl:apply-templates mode="combine"/>
	    </xsl:copy>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="combine">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="combine"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="comment()|processing-instruction()|text()" mode="combine">
    <xsl:copy/>
  </xsl:template>

  <!-- ====================================================================== -->

  <xsl:template match="ctrl:conditional" mode="conditional">
    <xsl:variable name="pat" select="@pattern"/>

    <xsl:choose>
      <xsl:when test="//rng:define[@name = $pat]">
        <xsl:if test="$debug != 0">
          <xsl:message>
            <xsl:text>Including conditional pattern=</xsl:text>
            <xsl:value-of select="$pat"/>
          </xsl:message>
        </xsl:if>
	<xsl:apply-templates mode="conditional"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$debug != 0">
          <xsl:message>
            <xsl:text>Excluding conditional pattern=</xsl:text>
            <xsl:value-of select="$pat"/>
          </xsl:message>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="conditional">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="conditional"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="comment()|processing-instruction()|text()"
		mode="conditional">
    <xsl:copy/>
  </xsl:template>

  <!-- ====================================================================== -->

  <xsl:template match="rng:start" mode="override">
    <xsl:choose>
      <xsl:when test="@override">
	<xsl:copy>
	  <xsl:copy-of select="@*[name(.) != 'override']"/>
	  <xsl:apply-templates mode="override"/>
	</xsl:copy>
      </xsl:when>
      <xsl:when test="//rng:start[@override]">
        <xsl:if test="$debug != 0">
          <xsl:message>
            <xsl:text>Suppressing original definition of start</xsl:text>
          </xsl:message>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates mode="override"/>
	</xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="rng:define" mode="override">
    <xsl:variable name="over" select="key('overrides', @name)"/>
    <xsl:choose>
      <xsl:when test="@override">
	<xsl:copy>
	  <xsl:copy-of select="@*[name(.) != 'override']"/>
	  <xsl:apply-templates mode="override"/>
	</xsl:copy>
      </xsl:when>
      <xsl:when test="$over">
        <xsl:if test="$debug != 0">
          <xsl:message>
            <xsl:text>Suppressing original definition of </xsl:text>
            <xsl:value-of select="@name"/>
          </xsl:message>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates mode="override"/>
	</xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="override">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="override"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="comment()|processing-instruction()|text()"
		mode="override">
    <xsl:copy/>
  </xsl:template>

  <!-- ============================================================ -->

  <xsl:template name="removeunused">
    <xsl:param name="doc"/>

    <xsl:variable name="unused">
      <xsl:for-each select="$doc//rng:define[@name]">
	<xsl:variable name="name" select="@name"/>
	<xsl:if test="count(key('refs',@name)) = 0">
          <xsl:text>1</xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="$doc//rng:ref[@name]">
	<xsl:variable name="name" select="@name"/>
	<xsl:if test="count(key('defs',@name)) = 0">
          <xsl:text>1</xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:if test="$doc//rng:div[not(.//rng:*)]">
        <xsl:text>1</xsl:text>
      </xsl:if>
      <xsl:if test="$doc//rng:choice[not(*)]">
        <xsl:text>1</xsl:text>
      </xsl:if>
      <xsl:if test="$doc//rng:zeroOrMore[not(*)]">
        <xsl:text>1</xsl:text>
      </xsl:if>
      <xsl:if test="$doc//rng:define[not(*)]">
        <xsl:text>1</xsl:text>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="string-length($unused) &gt; 0">
        <xsl:if test="$debug != 0">
          <xsl:message>
            <xsl:text>Removing </xsl:text>
            <xsl:value-of select="string-length($unused)"/>
            <xsl:text> patterns.</xsl:text>
          </xsl:message>
        </xsl:if>
	<xsl:variable name="doc2">
	  <xsl:apply-templates select="$doc" mode="remove-unused"/>
	</xsl:variable>
	<xsl:call-template name="removeunused">
	  <xsl:with-param name="doc" select="$doc2"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy-of select="$doc"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="rng:div" mode="remove-unused">
    <xsl:choose>
      <xsl:when test=".//rng:*">
	<xsl:copy>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates mode="remove-unused"/>
	</xsl:copy>
      </xsl:when>
      <xsl:when test="$debug != 0">
	<xsl:message>   Removing empty rng:div</xsl:message>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="rng:define[@name]" mode="remove-unused">
    <xsl:choose>
      <xsl:when test="count(key('refs', @name)) != 0 and *">
	<xsl:copy>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates mode="remove-unused"/>
	</xsl:copy>
      </xsl:when>
      <xsl:when test="$debug != 0">
	<xsl:message>   Removing <xsl:value-of select="@name"/>...</xsl:message>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="rng:ref[@name]" mode="remove-unused">
    <xsl:choose>
      <xsl:when test="key('defs',@name)/rng:notAllowed or count(key('defs',@name)) = 0">
        <xsl:if test="$debug != 0">
          <xsl:message>
            <xsl:text>   Removing ref to notAllowed element: </xsl:text>
            <xsl:value-of select="@name"/>
          </xsl:message>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates mode="remove-unused"/>
	</xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="rng:optional|rng:choice|rng:zeroOrMore" mode="remove-unused">
    <xsl:choose>
      <xsl:when test="*">
	<xsl:copy>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates mode="remove-unused"/>
	</xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$debug != 0">
          <xsl:message>
            <xsl:text>   Removing empty </xsl:text>
            <xsl:value-of select="local-name(.)"/>
          </xsl:message>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="remove-unused">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="remove-unused"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="comment()|processing-instruction()|text()"
		mode="remove-unused">
    <xsl:copy/>
  </xsl:template>

</xsl:stylesheet>

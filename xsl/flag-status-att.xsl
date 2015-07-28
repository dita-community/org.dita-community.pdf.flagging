<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs xd"
  version="2.0">
  <!-- =========================================================
       PDF2 Transformation Type Flagging Extensions
       
       This module implements flagging of changes marked using the
       @status attribute. This extends the base get-rules model template 
       from flag-rules.xsl to add rules for @status values. 
       
       The runtime XSLT parameter "flagStatusValues" turns on
       status flagging when the value evaluates to true ("true",
       "yes", "1", or "on"). The default is no status flagging.
       
       Copyright (c) 2015 DITA Community (dita-community.org)
       
       Source code contributed to the DITA community by 
       DeltaXML, http://www.deltaxml.com.
       
       ========================================================== -->
  
  <xsl:template match="*[@status]" mode="getrules">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    <xsl:variable name="doDebug" as="xs:boolean" select="true()"/>
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] flag-status-att: getrules, handling element <xsl:value-of select="concat(name(..), '/', name(.))"/>, @status="<xsl:value-of select="@status"/>"</xsl:message>
    </xsl:if>
    
    <xsl:choose>
      <xsl:when test="@status = ('new')">
         <prop
          action="flag"
          att="status"
          val="new"
          color="green"/>
      </xsl:when>
      <xsl:when test="@status = ('deleted')">
         <prop
          action="flag"
          att="status"
          val="new"
          color="red"
          style="line-through"
         />
      </xsl:when>
      <xsl:when test="@status = ('changed')">
         <prop
          action="flag"
          att="status"
          val="new"
          color="blue"
         />
      </xsl:when>
      <xsl:when test="@status = ('unchanged')">
        <!-- No flagging on unchanged -->
      </xsl:when>
    </xsl:choose>
    
    <xsl:next-match/>
  </xsl:template>
  
</xsl:stylesheet>
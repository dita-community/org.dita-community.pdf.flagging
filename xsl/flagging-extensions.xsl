<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs xd"
  version="2.0">
  
  <!-- =========================================================
       PDF2 Transformation Type Flagging Extensions
       
       This module extends the flagging-preprocess.xsl module
       from the PDF2 transform (using a new extension point
       introduced as a patch 1.8.5 and new in 2.2).
       
       It implements topic-level flagging for revisions (change
       bars) and conditional attributes.
       
       It also implements flagging of changes marked using the
       @status attribute.
       
       The runtime XSLT parameter "flagStatusValues" turns on
       status flagging when the value evaluates to true ("true",
       "yes", "1", or "on"). The default is no status flagging.
       
       Copyright (c) 2015 DITA Community (dita-community.org)
       
       Source code contributed to the DITA community by 
       DeltaXML, http://www.deltaxml.com.
       
       ========================================================== -->
       
  
  <xsl:include href="flag-topics.xsl"/>
  <xsl:include href="flag-status-att.xsl"/>
  
  <xsl:param name="flagStatusValues" as="xs:string" select="'false'"/>
  
  <xsl:variable name="doFlagStatusValues" as="xs:boolean"
     select="matches($flagStatusValues, 'yes|1|true|on', 'i')"
  />
  
  
</xsl:stylesheet>
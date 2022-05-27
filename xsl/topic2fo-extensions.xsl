<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs xd"
  version="2.0">
  
  <xsl:include href="commons.xsl"/>
  <xsl:include href="toc.xsl"/>
  
  <!-- Set to "true" to turn on PDF flagging tracing -->
  <xsl:param name="tracePdfFlagging" as="xs:string" select="'false'"/>
  
</xsl:stylesheet>
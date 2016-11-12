<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:exsl="http://exslt.org/common"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:exslf="http://exslt.org/functions"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:suitesol="http://suite-sol.com/namespaces/mapcounts"
  extension-element-prefixes="exsl"    
  exclude-result-prefixes="ot-placeholder opentopic exsl opentopic-index exslf opentopic-func dita2xslfo xs suitesol"
  version="2.0">
  
  <!-- Override to add flagging logic for whole topics -->
  <xsl:template match="*" mode="processTopic">
    <fo:block xsl:use-attribute-sets="topic">
      <xsl:apply-templates select="suitesol:flagging-inside"/>
      <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
        <fo:marker marker-class-name="current-topic-number">
          <xsl:number format="1"/>
        </fo:marker>
      </xsl:if>
      <xsl:apply-templates select="." mode="commonTopicProcessing"/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="*" mode="commonTopicProcessing">
    <xsl:apply-templates select="suitesol:changebar-start"/>
    <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
    <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>
    <xsl:apply-templates select="*[not(contains(@class, ' topic/title ')) and
      not(contains(@class, ' topic/prolog ')) and
      not(contains(@class, ' topic/topic ')) and not(self::suitesol:*)]"/>
    <xsl:apply-templates select="." mode="buildRelationships"/>
    <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
    <xsl:apply-templates select="." mode="topicEpilog"/>
    <xsl:apply-templates select="suitesol:changebar-end"/>
  </xsl:template>
  
  <xsl:template match="*" mode="processConcept">
    <fo:block xsl:use-attribute-sets="concept">
      <xsl:apply-templates select="suitesol:flagging-inside"/>
      <xsl:comment> concept/concept </xsl:comment>
      <xsl:apply-templates select="." mode="commonTopicProcessing"/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="*" mode="processReference">
    <fo:block xsl:use-attribute-sets="reference">
      <xsl:apply-templates select="suitesol:flagging-inside"/>
      <xsl:apply-templates select="." mode="commonTopicProcessing"/>
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>
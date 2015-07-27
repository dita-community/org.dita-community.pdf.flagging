<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:suitesol="http://suite-sol.com/namespaces/mapcounts"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl opentopic-func exsl exslf xs"
    version="2.0">

 
   
   <!-- Override of topic-level flagging 
  
        Actually DO flag topics, just like in the DITA-OT (>= 1.7) xhtml output 
   -->
   <xsl:template match="*[contains(@class, ' topic/topic ')]"
              priority="50">
      <xsl:param name="doDebug" as="xs:boolean" select="false()"/>
     
     <xsl:variable name="doDebug" as="xs:boolean" select="true()"/>
     <xsl:if test="true() or $doDebug">
       <xsl:message> + [DEBUG] topic/topic: Override for topic-level flagging.</xsl:message>
     </xsl:if>
      <xsl:variable name="id">
         <xsl:value-of select="generate-id(.)"/>
      </xsl:variable>
      
      <xsl:variable name="flagrules">
         <xsl:apply-templates select="." mode="getrules">
         </xsl:apply-templates>
      </xsl:variable>
     <xsl:if test="$doDebug">
       <xsl:message> + [DEBUG] flagrules:<xsl:sequence select="$flagrules"/></xsl:message>
     </xsl:if>
      <xsl:copy>        
         <xsl:apply-templates select="@*"/>
         <!-- flagging (of colour/font needs to be here to be applied to the topic level fo:block as attrs.
         This puts a suitesol:  element in place ready for stage2 processing.  -->
         <xsl:apply-templates select="." mode="flagging">
            <xsl:with-param name="pi-name">flagging-inside</xsl:with-param>
            <xsl:with-param name="id" select="$id" />
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:apply-templates>
         <!-- changebars need to be inside a block, if outside as in some of the other templates here then
         they would end up as children of fo:root or fo:page-sequence which isn't valid FO -->
         <xsl:apply-templates select="." mode="changebar">
            <xsl:with-param name="pi-name">start</xsl:with-param>
            <xsl:with-param name="id" select="$id" />
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:apply-templates>
         <xsl:call-template name="start-flagit">
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:call-template>
         <!-- process child elements -->
         <xsl:apply-templates/>
         <xsl:call-template name="end-flagit">
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:call-template>
         <xsl:apply-templates select="." mode="changebar">
            <xsl:with-param name="pi-name">end</xsl:with-param>
            <xsl:with-param name="id" select="$id" />
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:apply-templates>
      </xsl:copy>
   </xsl:template>
                   
</xsl:stylesheet>
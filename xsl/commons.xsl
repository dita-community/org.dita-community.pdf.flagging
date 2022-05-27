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
    expand-text="yes"
    version="3.0">

  <xsl:variable name="doTracePdfFlagging" as="xs:boolean" 
    select="matches($tracePdfFlagging, '1|yes|true|on', 'i')"
  />
  
    <!-- Override to enble change bars for the title, shortdesc, abstract, and body
         of a topic but *not* any nested topics.
         
         This template does not itself generate the change bars. Instead, it passes
         a part of tunnel parameters to the title and direct non-topic-element 
         templates so that they can emit change bars as appropriate.
         
         In particular, within bodies, it may be necessary to avoid putting change
         bars around generated components such as tables of contents.
      -->
    <xsl:template match="*" mode="commonTopicProcessing">
      <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
      
      <xsl:if test="$doDebug or $doTracePdfFlagging">
        <xsl:message>+ [DEBUG] (pdf.flagging) commonTopicProcessing: - handling <xsl:value-of select="concat(name(..), '/', name(.))"/>, id="<xsl:value-of select="@oid"/>"</xsl:message>
      </xsl:if>
      
      <xsl:variable name="change-bar-start" as="node()*">
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>      
      </xsl:variable>
      <xsl:variable name="change-bar-end" as="node()*">
        <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>      
      </xsl:variable>

      <xsl:if test="$doDebug or $doTracePdfFlagging">
        <xsl:message>+ [DEBUG] pdf.flagging:   change-bar-start: <xsl:sequence select="$change-bar-start"/></xsl:message>
        <xsl:message>+ [DEBUG] pdf.flagging:   change-bar-end: <xsl:sequence select="$change-bar-start"/></xsl:message>
      </xsl:if>
      
      <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="flag-attributes"/>      
      <xsl:apply-templates select="*[contains(@class, ' topic/title ')]">
        <xsl:with-param name="topic-change-bar-start" as="node()*" tunnel="yes" select="$change-bar-start"/>
        <xsl:with-param name="topic-change-bar-end" as="node()*" tunnel="yes" select="$change-bar-end"/>        
      </xsl:apply-templates>
      
      <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]">
        <xsl:with-param name="topic-change-bar-start" as="node()*" tunnel="yes" select="$change-bar-start"/>
        <xsl:with-param name="topic-change-bar-end" as="node()*" tunnel="yes" select="$change-bar-end"/>        
      </xsl:apply-templates>
      <xsl:apply-templates 
        select="
          * except 
            (*[contains(@class, ' topic/title ')] | 
             *[contains(@class, ' topic/prolog ')] |
             *[contains(@class, ' topic/topic ')]
            )
        ">
        <xsl:with-param name="topic-change-bar-start" as="node()*" tunnel="yes" select="$change-bar-start"/>
        <xsl:with-param name="topic-change-bar-end" as="node()*" tunnel="yes" select="$change-bar-end"/>        
      </xsl:apply-templates>
      <!-- Unset the change bar start so that nested topics are not also marked with change bars.
        -->
      <xsl:apply-templates select="*[contains(@class,' topic/topic ')]">
        <xsl:with-param name="topic-change-bar-start" as="node()*" tunnel="yes" select="()"/>
        <xsl:with-param name="topic-change-bar-end" as="node()*" tunnel="yes" select="()"/>                
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="topicEpilog">
        <xsl:with-param name="topic-change-bar-start" as="node()*" tunnel="yes" select="$change-bar-start"/>
        <xsl:with-param name="topic-change-bar-end" as="node()*" tunnel="yes" select="$change-bar-end"/>        
      </xsl:apply-templates>
    </xsl:template>
  
  <!-- Override of template in topic.xsl to put topic-level change bars around titles -->  
  <xsl:template match="*" mode="processTopicTitle">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    <xsl:param name="topic-change-bar-start" as="node()*" tunnel="yes" select="()"/>
    <xsl:param name="topic-change-bar-end" as="node()*" tunnel="yes" select="()"/>        
    
    <xsl:if test="$doDebug or $doTracePdfFlagging">
      <xsl:message>+ [DEBUG] pdf.flagging: getTitle - handling {name(..)}/{name(.)}, "{normalize-space(.)}"</xsl:message>
    </xsl:if>

    <xsl:variable name="level" as="xs:integer">
      <xsl:apply-templates select="." mode="get-topic-level"/>
    </xsl:variable>
    <xsl:variable name="attrSet1">
      <xsl:apply-templates select="." mode="createTopicAttrsName">
        <xsl:with-param name="theCounter" select="$level"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="attrSet2" select="concat($attrSet1, '__content')"/>
    <fo:block>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="processAttrSetReflection">
        <xsl:with-param name="attrSet" select="$attrSet1"/>
        <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
      </xsl:call-template>
      <fo:block>
        <xsl:call-template name="processAttrSetReflection">
          <xsl:with-param name="attrSet" select="$attrSet2"/>
          <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
        </xsl:call-template>
        <xsl:if test="$level = 1">
          <xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
        </xsl:if>
        <xsl:if test="$level = 2">
          <xsl:apply-templates select="." mode="insertTopicHeaderMarker">
            <xsl:with-param name="marker-class-name" as="xs:string">current-h2</xsl:with-param>
          </xsl:apply-templates>
        </xsl:if>
        <fo:wrapper id="{parent::node()/@id}"/>
        <fo:wrapper>
          <xsl:attribute name="id">
            <xsl:call-template name="generate-toc-id">
              <xsl:with-param name="element" select=".."/>
            </xsl:call-template>
          </xsl:attribute>
        </fo:wrapper>
        <xsl:call-template name="pullPrologIndexTerms"/>
        <!-- Override: -->
        <xsl:sequence select="$topic-change-bar-start"/>
        <xsl:apply-templates select="." mode="getTitle"/>
        <!-- Override: -->
        <xsl:sequence select="$topic-change-bar-end"/>
      </fo:block>
    </fo:block>
  </xsl:template>  
  
  <!-- Override of template in topic.xsl to put topic-level change bars around the topic body -->
  <xsl:template match="*[contains(@class,' topic/body ')]">    
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    <xsl:param name="topic-change-bar-start" as="node()*" tunnel="yes" select="()"/>
    <xsl:param name="topic-change-bar-end" as="node()*" tunnel="yes" select="()"/>        
    
    <xsl:if test="$doDebug or $doTracePdfFlagging">
      <xsl:message>+ [DEBUG] pdf.flagging: topic/body - handling {name(..)}/{name(.)}, "{normalize-space(.)}"</xsl:message>
    </xsl:if>

    <xsl:sequence select="$topic-change-bar-start"/>
    <xsl:next-match/>
    <xsl:sequence select="$topic-change-bar-end"/>
  </xsl:template>
  
  <!-- Override of template in topic.xsl to put topic-level change bars around the topic body -->
  <xsl:template match="*[contains(@class,' topic/abstract ')]">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    <xsl:param name="topic-change-bar-start" as="node()*" tunnel="yes" select="()"/>
    <xsl:param name="topic-change-bar-end" as="node()*" tunnel="yes" select="()"/>        
    
    <xsl:if test="$doDebug or $doTracePdfFlagging">
      <xsl:message>+ [DEBUG] pdf.flagging: topic/abstract - handling {name(..)}/{name(.)}, "{normalize-space(.)}"</xsl:message>
    </xsl:if>

    <xsl:sequence select="$topic-change-bar-start"/>
    <xsl:next-match/>
    <xsl:sequence select="$topic-change-bar-end"/>
  </xsl:template>

  <!-- Shortdesc not within abstract -->
  <xsl:template match="*[contains(@class,' topic/topic ')]/*[contains(@class,' topic/shortdesc ')]">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    <xsl:param name="topic-change-bar-start" as="node()*" tunnel="yes" select="()"/>
    <xsl:param name="topic-change-bar-end" as="node()*" tunnel="yes" select="()"/>        
    
    <xsl:if test="$doDebug or $doTracePdfFlagging">
      <xsl:message>+ [DEBUG] pdf.flagging: shortdesc in topic - handling {name(..)}/{name(.)}, "{normalize-space(.)}"</xsl:message>
    </xsl:if>
    
    <xsl:sequence select="$topic-change-bar-start"/>
    <xsl:next-match/>
    <xsl:sequence select="$topic-change-bar-end"/>
  </xsl:template>
  
  <!-- Override of topic.xsl template to add change bar parameters -->
  <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="processTopic">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:if test="$doDebug or $doTracePdfFlagging or ($doTraceTopicHandling and matches(@class, ' topic/topic '))">
      <xsl:message>+ [DEBUG] (pdf.flagging) processTopic: fallback, <xsl:value-of select="concat(name(..), '/', name(.))"/>, id="<xsl:value-of select="@oid"/>" (<xsl:value-of select="normalize-space(*[contains(@class, ' topic/title ')])"/>)</xsl:message>
    </xsl:if>
    
    <xsl:variable name="change-bar-start" as="node()*">
      <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>      
    </xsl:variable>
    <xsl:variable name="change-bar-end" as="node()*">
      <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>      
    </xsl:variable>
    
    <fo:block xsl:use-attribute-sets="topic">
      <xsl:apply-templates select="." mode="commonTopicProcessing">
        <xsl:with-param name="topic-change-bar-start" as="node()*" tunnel="yes" select="$change-bar-start"/>
        <xsl:with-param name="topic-change-bar-end" as="node()*" tunnel="yes" select="$change-bar-end"/>                        
      </xsl:apply-templates>
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>

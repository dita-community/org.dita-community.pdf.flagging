<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    exclude-result-prefixes="xsl opentopic-func exsl exslf"
    xmlns:suitesol="http://suite-sol.com/namespaces/mapcounts"
    version="2.0">

   <xsl:import href="flagging-preprocessImpl.xsl"/>
   <xsl:import href="flag-rules.xsl"/>
   <xsl:import href="../../../../xsl/common/dita-utilities.xsl"/>
   <xsl:import href="../../../../xsl/common/output-message.xsl"/>

  <dita:extension id="dita.xsl.xslfo.flagging-preprocess"
    behavior="org.dita.dost.platform.ImportXSLAction"
    xmlns:dita="http://dita-ot.sourceforge.net"
  />
  
   <!--preserve the doctype-->
   <xsl:output method="xml" encoding="UTF-8" indent="no"></xsl:output>


   <xsl:param name="filterFile" select="''"/>


</xsl:stylesheet>
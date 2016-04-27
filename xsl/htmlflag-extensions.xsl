<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <!-- Text decoration values not allowed by the base OT code -->
  <xsl:variable name="textDecorationValues" as="xs:string+"
    select="('line-through')"
  />
  
  <!-- Override handling of outputclass for ditavalstyle to add line-through from the <prop> style attribute, if present. -->
  <xsl:template match="*[contains(@class,' ditaot-d/ditaval-startprop ')]/@outputclass" mode="add-ditaval-style">
    <xsl:variable name="baseValue" as="xs:string"
      select="."
    />
    <xsl:variable name="styleValues" as="xs:string*"
      select="tokenize(../prop/@style, ';')"
    />
    <xsl:variable name="styleTokens" as="xs:string*"
      select="tokenize($baseValue, ';')"
    />
    <xsl:variable name="newValues" as="xs:string*"
      select="for $str in $styleValues 
                  return if ($str = $styleTokens) 
                            then () 
                            else if ($str = $textDecorationValues) 
                                    then concat('text-decoration:', $str) 
                                    else ()"
    />
    <xsl:attribute name="style"><xsl:value-of select="string-join(($styleTokens, $newValues), ';')"/></xsl:attribute>
  </xsl:template>
  
  
</xsl:stylesheet>
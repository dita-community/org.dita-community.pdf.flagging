<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  <!-- Extensions to the topicpull process to add @status to the @domains attribute
       to make the OT think it's a specialization of @props.
       
    -->
  
  <xsl:template match="@domains">
    <xsl:attribute name="{name(.)}"
      select="(string(.), 'a(props status)')"
    />
  </xsl:template>
  
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:param name="day" select="''"/>
    <xsl:variable name="l1_bullet" select="'* '"/>
    
    <xsl:template match="/">
        <xsl:text>Yesterday's work:&#10;</xsl:text>
        <xsl:for-each select="//task[tracking/time/@date=$day]">
            <xsl:sort data-type="text" order="descending" select="description/project"/>
            <xsl:text>&#10;</xsl:text>
            <xsl:value-of select="$l1_bullet"/>
            <xsl:value-of select="./task_name"/>
        </xsl:for-each>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
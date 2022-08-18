<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <!-- Determine week based on parameter input -->
    <xsl:param name="monday" select="'2022-08-01'"/>
    <xsl:variable name="l1_bullet" select="'* '"/>
    <xsl:variable name="l2_bullet" select="'  * '"/>
    
    <xsl:template match="@*|node()">
            <xsl:apply-templates/>
    </xsl:template>
        
    <xsl:template match="week[@monday = $monday]">
        <!-- Output to document; construct filename+path from input date -->
        <xsl:result-document href="{substring($monday,1,4)}/weekly_{$monday}.md">

            <!-- Construct header using date -->
            <xsl:text># Weekly Report -- Monday </xsl:text>
            <xsl:value-of select="format-date(xs:date($monday), '[MNn] [D], [Y0001]')"/>
            <xsl:text>&#10;&#10;</xsl:text>

            <!-- List tasks noted as reportable for department standup -->
            <xsl:text>## Department Meeting Report&#10;&#10;</xsl:text>
            <xsl:for-each-group select="task[reporting/reporting_level/@value != 'none']" group-by="description/project">
                <xsl:value-of select="concat($l1_bullet,current-grouping-key()&#10;)"/>
                <xsl:for-each select="current-group()">
                    <xsl:text>&#10;</xsl:text>
                    <xsl:value-of select="$l2_bullet"/>
                    <xsl:value-of select="reporting/narrative"/>
                </xsl:for-each>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each-group>
            <xsl:for-each select="task[not(description/project)]">
                <xsl:value-of select="$l1_bullet"/>
                <xsl:value-of select="reporting/narrative"/>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
            <xsl:text>&#10;&#10;</xsl:text>
 <!--           
            <!-\- Compute time spent in PD areas and compare to FTE percents -\->
            <xsl:text>## FTE Check&#10;&#10;</xsl:text>
            <xsl:for-each select="task/tracking/time">
                <xsl:variable name="time_spent">
                    <xsl:value-of select="xs:time(end)-xs:time(start)"/>
                </xsl:variable>
                <xsl:value-of select="$time_spent"/>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
             -->

            <xsl:text>&#10;</xsl:text>
        </xsl:result-document>
    </xsl:template>
   
    
    
    <!--//task[position()=last()]/tracking/time/[xs:time(end)] - //task[position()=last()]/tracking/time/xs:time(start)-->
    
</xsl:stylesheet>
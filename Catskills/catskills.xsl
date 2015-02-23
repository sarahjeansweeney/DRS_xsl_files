<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="/mods:mods">
        <mods:mods xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:METS="http://www.loc.gov/METS/" ID="cats001518" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-3.xsd">
            <xsl:copy-of select="mods:titleInfo"/>
            <xsl:copy-of select="mods:name"/>
            <xsl:copy-of select="mods:typeOfResource"/>
            <xsl:copy-of select="mods:genre"/>
            <xsl:copy-of select="originInfo"/>
            <xsl:copy-of select="mods:language"/>
            <xsl:copy-of select="mods:physicalDescription"/>
            <xsl:copy-of select="mods:abstract"/>
            <xsl:copy-of select="mods:tableOfContents"/>
            <xsl:copy-of select="mods:targetAudience"/>
            <xsl:copy-of select="mods:note"/>
            <xsl:copy-of select="mods:subject"/>
            <xsl:copy-of select="mods:classification"/>
            <xsl:copy-of select="mods:relatedItem"/>
            <xsl:copy-of select="mods:identifier"/>
            <xsl:copy-of select="mods:location"/>
            <xsl:copy-of select="mods:accessCondition"/>
            <xsl:copy-of select="mods:part"/>
            <xsl:copy-of select="mods:extension"/>
            <xsl:copy-of select="mods:recordInfo"/>
        </mods:mods>
    </xsl:template>
    
</xsl:stylesheet>
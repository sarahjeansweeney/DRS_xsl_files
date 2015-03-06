<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="/mods:mods">
        <mods:mods xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
            <mods:titleInfo>
                <mods:title>
                    <xsl:text>Supplemental files for "</xsl:text>
                    <xsl:value-of select="mods:titleInfo/mods:title"/>
                    <xsl:text>"</xsl:text>
                </mods:title>
            </mods:titleInfo>
            <xsl:copy-of select="mods:name"/>
            <xsl:copy-of select="mods:subject"/>
            <xsl:copy-of select="mods:accessCondition"/>
        </mods:mods>
    </xsl:template>
</xsl:stylesheet>

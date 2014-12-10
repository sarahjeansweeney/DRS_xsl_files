<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:mods="http://www.loc.gov/mods/v3">
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="/mods:modsCollection/mods:mods">
        <xsl:variable name="id" select="@ID"/>
        <xsl:result-document href="{@ID}.mods.xml">
            
                <!-- Changed to mods:modsCollection, declaired namespace -->
                <mods:mods xmlns:mods="http://www.loc.gov/mods/v3"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
                    <xsl:copy-of select="*"/>
                </mods:mods>
            
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

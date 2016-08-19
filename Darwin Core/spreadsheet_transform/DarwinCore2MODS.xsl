<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:drs="https://repository.neu.edu/spec/v1" 
    xmlns:mods="http://www.loc.gov/mods/v3" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:niec="http://repository.neu.edu/schema/niec"
    xmlns:dcterms="http://purl.org/dc/terms/" 
    xmlns:dwc="http://rs.tdwg.org/dwc/terms/" 
    xmlns:dwr="http://rs.tdwg.org/dwc/xsd/simpledarwincore/"
    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" method="xml"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/dwr:SimpleDarwinRecordSet">
        <mods:modsCollection>
            <xsl:for-each select="dwr:SimpleDarwinRecord">


                <xsl:variable name="mods_filename">
                    <xsl:value-of select="substring-before(@filename, '.')"/>
                </xsl:variable>

                <mods:mods filename="{$mods_filename}">

                    <!-- TITLE -->

                    <mods:titleInfo>
                        <mods:title>
                            <xsl:value-of select="dwc:scientificName"/>
                            <xsl:if test="dwc:vernacularName">
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="dwc:vernacularName"/>
                                <xsl:text>)</xsl:text>
                            </xsl:if>
                        </mods:title>
                    </mods:titleInfo>

                    <!-- RESEARCHER NAME -->

                    <xsl:if test="dwc:identifiedBy">

                        <mods:name>
                            <mods:namePart type="family">
                                <xsl:value-of select="substring-after(dwc:identifiedBy, ' ')"/>
                            </mods:namePart>
                            <mods:namePart type="given">
                                <xsl:value-of select="substring-before(dwc:identifiedBy, ' ')"/>
                            </mods:namePart>
                            <mods:role>
                                <mods:roleTerm authority="marcrelator" type="text">Researcher</mods:roleTerm>
                            </mods:role>
                        </mods:name>
                    </xsl:if>

                    <!-- STANDARD MODS VALUES, no transformation -->

                    <mods:typeOfResource>still image</mods:typeOfResource>
                    <mods:genre authority="aat">photographs</mods:genre>
                    <mods:physicalDescription>
                        <mods:form authority="marcform">electronic</mods:form>
                    </mods:physicalDescription>

                    <!-- DATE -->
                    <xsl:if test="dwc:eventDate">

                        <mods:originInfo>
                            <mods:dateCreated encoding="w3cdtf" keyDate="yes">
                                <xsl:value-of select="dwc:eventDate"/>
                            </mods:dateCreated>
                        </mods:originInfo>
                    </xsl:if>

                    <!-- ABSTRACT -->
                    <mods:abstract>
                        <xsl:value-of select="dwc:scientificName"/>
                        <xsl:text> sample collected </xsl:text>
                        <xsl:value-of select="dwc:eventDate"/>
                        <xsl:text> from </xsl:text>
                        <xsl:value-of select="substring-after(substring-after(dwc:higherGeography, '| '), '| ')"/>
                        <xsl:text> as part of the Marine Science Center Ocean Genome Legacy Project.</xsl:text>
                    </mods:abstract>

                    <!-- NOTES -->

                    <xsl:if test="dwc:higherClassification">
                        <mods:note type="Taxonomy">
                            <xsl:value-of select="dwc:higherClassification"/>
                        </mods:note>
                    </xsl:if>

                    <xsl:if test="dwc:organismRemarks">
                        <mods:note type="Organism Remarks">
                            <xsl:value-of select="dwc:organismRemarks"/>
                        </mods:note>
                    </xsl:if>

                    <xsl:if test="dwc:fieldNotes">
                        <mods:note type="Field Notes">
                            <xsl:value-of select="dwc:fieldNotes"/>
                        </mods:note>
                    </xsl:if>

                    <mods:subject>
                        <mods:topic>Preserved Specimen</mods:topic>
                    </mods:subject>

                    <mods:subject>
                        <mods:topic>
                            <xsl:choose>
                                <xsl:when test="dwc:genus">
                                    <xsl:value-of select="dwc:genus"/>
                                </xsl:when>
                                <xsl:when test="dwc:family">
                                    <xsl:value-of select="dwc:family"/>
                                </xsl:when>
                                <xsl:when test="dwc:order">
                                    <xsl:value-of select="dwc:order"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="dwc:class"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </mods:topic>
                    </mods:subject>

                    <xsl:if test="dwc:vernacularName">
                        <mods:subject>
                            <mods:topic>
                                <xsl:value-of select="dwc:vernacularName"/>
                            </mods:topic>
                        </mods:subject>
                    </xsl:if>

                    <xsl:if test="dwc:higherGeography">
                        <mods:subject>
                            <mods:geographic>
                                <xsl:value-of select="substring-after(substring-after(dwc:higherGeography, ' |'), ' | ')"/>
                            </mods:geographic>
                        </mods:subject>
                    </xsl:if>

                    <xsl:if test="dwc:decimalLongitude">
                        <mods:subject>
                            <mods:cartographics>
                                <mods:coordinates>
                                    <xsl:value-of select="dwc:decimalLongitude"/>
                                    <xsl:if test="dwc:decimalLatitude">
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="dwc:decimalLatitude"/>
                                    </xsl:if>
                                </mods:coordinates>
                            </mods:cartographics>
                        </mods:subject>
                    </xsl:if>

                    <!-- IDENTIFIER needs display lable and type -->
                    <xsl:if test="dwc:organismID">
                        <mods:identifier displayLabel="Organism ID">
                            <xsl:value-of select="dwc:organismID"/>
                        </mods:identifier>
                    </xsl:if>

                    <xsl:if test="dcterms:accessRights">
                        <mods:accessCondition type="use and reproduction">
                            <xsl:value-of select="dcterms:accessRights"/>
                        </mods:accessCondition>
                    </xsl:if>

                    <mods:extension>
                        <dwr:SimpleDarwinRecord>
                            <xsl:copy-of select="dwc:organismID"/>
                            <xsl:copy-of select="dwc:catalogNumber"/>
                            <xsl:copy-of select="dwc:basisOfRecord"/>
                            <xsl:copy-of select="dwc:otherCatalogNumbers"/>
                            <xsl:copy-of select="dwc:previousIdentifications"/>
                            <xsl:copy-of select="dwc:organismRemarks"/>
                            <xsl:copy-of select="dwc:identifiedBy"/>
                            <xsl:copy-of select="dwc:taxonID"/>
                            <xsl:copy-of select="dwc:kingdom"/>
                            <xsl:copy-of select="dwc:phylum"/>
                            <xsl:copy-of select="dwc:class"/>
                            <xsl:copy-of select="dwc:order"/>
                            <xsl:copy-of select="dwc:family"/>
                            <xsl:copy-of select="dwc:genus"/>
                            <xsl:copy-of select="dwc:higherClassification"/>
                            <xsl:copy-of select="dwc:specificEpithet"/>
                            <xsl:copy-of select="dwc:identificationQualifier"/>
                            <xsl:copy-of select="dwc:scientificNameAuthorship"/>
                            <xsl:copy-of select="dwc:scientificName"/>
                            <xsl:copy-of select="dwc:vernacularName"/>
                            <xsl:copy-of select="dwc:locationID"/>
                            <xsl:copy-of select="dwc:waterbody"/>
                            <xsl:copy-of select="dwc:higherGeography"/>
                            <xsl:copy-of select="dwc:verbatimDepth"/>
                            <xsl:copy-of select="dwc:decimalLatitude"/>
                            <xsl:copy-of select="dwc:decimalLongitude"/>
                            <xsl:if test="dwc:decimalLatitude">
                                <dwc:geodeticDatum>
                                    <xsl:text>WGS84</xsl:text>
                                </dwc:geodeticDatum>
                            </xsl:if>
                            <xsl:copy-of select="dwc:country"/>
                            <xsl:copy-of select="dwc:countryCode"/>
                            <xsl:copy-of select="dwc:locationRemarks"/>
                            <xsl:copy-of select="dwc:eventID"/>
                            <xsl:copy-of select="dwc:eventDate"/>
                            <xsl:copy-of select="dwc:fieldNumber"/>
                            <xsl:copy-of select="dwc:samplingProtocol"/>
                            <xsl:copy-of select="dwc:fieldNotes"/>
                            <xsl:copy-of select="dcterms:accessRights"/>
                            <!--<xsl:copy-of select="dwc:associatedMedia"/>  -->
                        </dwr:SimpleDarwinRecord>
                    </mods:extension>
                </mods:mods>
            </xsl:for-each>
        </mods:modsCollection>
    </xsl:template>

</xsl:stylesheet>

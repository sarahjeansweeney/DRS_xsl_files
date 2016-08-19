<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:drs="https://repository.neu.edu/spec/v1" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:niec="http://repository.neu.edu/schema/niec"
    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dwc="http://rs.tdwg.org/dwc/terms/" xmlns:dwr="http://rs.tdwg.org/dwc/xsd/simpledarwincore/" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" method="xml"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/dwr:SimpleDarwinRecordSet">

        <dwr:SimpleDarwinRecordSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dwc="http://rs.tdwg.org/dwc/terms/" xmlns:dwr="http://rs.tdwg.org/dwc/xsd/simpledarwincore/"
            xsi:schemaLocation="http://rs.tdwg.org/dwc/xsd/simpledarwincore/  http://rs.tdwg.org/dwc/xsd/tdwg_dwc_simple.xsd">

            <xsl:for-each select="dwr:SimpleDarwinRecord">
                <dwr:SimpleDarwinRecord id="{@id}" filename="{@filename}">

                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:organismID, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:organismID"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:catalogNumber, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:catalogNumber"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:basisOfRecord, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:basisOfRecord"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:otherCatalogNumbers, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:otherCatalogNumbers"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:previousIdentifications, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:previousIdentifications"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:organismRemarks, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:organismRemarks"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:identifiedBy, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:identifiedBy"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:taxonID, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:taxonID"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:kingdom, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:kingdom"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:phylum, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:phylum"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:class, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:class"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:order, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:order"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:family, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:family"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:genus, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:genus"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:higherClassification, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:higherClassification"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:specificEpithet, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:specificEpithet"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:identificationQualifier, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:identificationQualifier"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:scientificNameAuthorship, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:scientificNameAuthorship"/>        
                        </xsl:otherwise>
                    </xsl:choose>

                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:scientificName, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:scientificName"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:vernacularName, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:vernacularName"/>        
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:locationID, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:locationID"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:waterbody, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:waterbody"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:higherGeography, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:higherGeography"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:verbatimDepth, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:verbatimDepth"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:decimalLatitude, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:decimalLatitude"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:decimalLongitude, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:decimalLongitude"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:country, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:country"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:countryCode, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:countryCode"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:locationRemarks, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:locationRemarks"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:eventID, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:eventID"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:eventDate, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:eventDate"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:fieldNumber, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:fieldNumber"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:samplingProtocol, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:samplingProtocol"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dwc:fieldNotes, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dwc:fieldNotes"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    <xsl:choose>
                        <xsl:when test="contains(dcterms:accessRights, 'null')"/>
                        <xsl:otherwise>
                            <xsl:copy-of select="dcterms:accessRights"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <!--<xsl:copy-of select="dwc:associatedMedia"/>  -->
                </dwr:SimpleDarwinRecord>
            </xsl:for-each>
        </dwr:SimpleDarwinRecordSet>
    </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:dwc="http://rs.tdwg.org/dwc/terms/"
    xmlns:dwr="http://rs.tdwg.org/dwc/xsd/simpledarwincore/" exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes" method="xml"></xsl:output>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <dwr:SimpleDarwinRecordSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://rs.tdwg.org/dwc/xsd/simpledarwincore/  http://rs.tdwg.org/dwc/xsd/tdwg_dwc_simple.xsd"
            xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dwc="http://rs.tdwg.org/dwc/terms/"
            xmlns:dwr="http://rs.tdwg.org/dwc/xsd/simpledarwincore/">
            <xsl:apply-templates select="//ROW"/>
        </dwr:SimpleDarwinRecordSet>
    </xsl:template>

    <xsl:template match="ROW">
        <xsl:variable name="CollectionEventID_fk">
            <xsl:value-of select="CollectionEventID_fk"/>
        </xsl:variable>
        <xsl:variable name="CollectionLocationID_fk">
            <xsl:value-of
                select="document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]/CollectionLocationID_fk"
            />
        </xsl:variable>
        <xsl:variable name="SpecimenID_pk">
            <xsl:value-of select="SpecimenID_pk"/>
        </xsl:variable>
        <dwr:SimpleDarwinRecord>
            <xsl:apply-templates/>
            <xsl:apply-templates
                select="document('locations.xml')//ROW[CollectionLocationID_pk = $CollectionLocationID_fk]"
                mode="auxilliary"/>
            <xsl:apply-templates
                select="document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]"
                mode="auxilliary"/>
            <xsl:apply-templates
                select="document('images.xml')//ROW[SpecimenID_fk = $SpecimenID_pk]/Filename"/>
            <xsl:if
                test="document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]/VesselName/text() or document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]/CruiseNumber/text() or document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]/DiveNumber/text() or document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]/Notes/text()">
                <dwc:fieldNotes>
                    <xsl:apply-templates select="document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]/VesselName" mode="event"/>
                    <xsl:apply-templates select="document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]/CruiseNumber"  mode="event"/>
                    <xsl:apply-templates select="document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]//DiveNumber" mode="event"/>
                    <xsl:apply-templates select="document('events.xml')//ROW[CollectionEventID_pk = $CollectionEventID_fk]//Notes" mode="event"/>
                </dwc:fieldNotes>
            </xsl:if>
            <xsl:apply-templates select="document('locations.xml')//ROW[CollectionLocationID_pk = $CollectionLocationID_fk]/Notes" mode="location"/>
        </dwr:SimpleDarwinRecord>
    </xsl:template>

    <xsl:template match="ROW" mode="auxilliary">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- obtain taxonomic data from specimens file-->
    <xsl:template match="Kingdom">
        <dwc:kingdom>
            <xsl:value-of select="DATA"/>
        </dwc:kingdom>
    </xsl:template>
    <xsl:template match="Phylum">
        <dwc:phylum>
            <xsl:value-of select="DATA"/>
        </dwc:phylum>
    </xsl:template>
    <xsl:template match="Class">
        <dwc:class>
            <xsl:value-of select="DATA"/>
        </dwc:class>
    </xsl:template>
    <xsl:template match="Order">
        <dwc:order>
            <xsl:value-of select="DATA"/>
        </dwc:order>
    </xsl:template>
    <xsl:template match="Family">
        <dwc:family>
            <xsl:value-of select="DATA"/>
        </dwc:family>
    </xsl:template>
    <xsl:template match="Genus">
        <dwc:genus>
            <xsl:value-of select="DATA"/>
        </dwc:genus>
    </xsl:template>
    <xsl:template match="ScientificName">
        <dwc:scientificName>
            <xsl:value-of select="DATA"/>
        </dwc:scientificName>
    </xsl:template>


    <!-- Obtain location data from locations file -->
    <xsl:template match="Longitude">
        <dwc:decimalLongitude>
            <xsl:apply-templates/>
        </dwc:decimalLongitude>
    </xsl:template>
    <xsl:template match="Latitude">
        <dwc:decimalLatitude>
            <xsl:apply-templates/>
        </dwc:decimalLatitude>
    </xsl:template>
    <xsl:template match="Island">
        <dwc:island>
            <xsl:apply-templates/>
        </dwc:island>
    </xsl:template>
    <xsl:template match="IslandGroup">
        <dwc:islandGroup>
            <xsl:apply-templates/>
        </dwc:islandGroup>
    </xsl:template>
    <xsl:template match="Landmark">
        <dwc:locality>
            <xsl:apply-templates/>
        </dwc:locality>
    </xsl:template>
    
    <xsl:template match="Depth">
        <dwc:verbatimDepth>
            <xsl:apply-templates/>
            <xsl:text> m</xsl:text>
        </dwc:verbatimDepth>
    </xsl:template>
    <xsl:template match="Ocean">
        <dwc:waterbody>
            <xsl:apply-templates/>

            <xsl:if test="../Waterbody/text()">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="../Waterbody"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
        </dwc:waterbody>
    </xsl:template>

    <xsl:template match="Country">
        <dwc:country>
            <xsl:apply-templates/>
        </dwc:country>
    </xsl:template>
    <xsl:template match="State">
        <dwc:stateProvince>
            <xsl:apply-templates/>
        </dwc:stateProvince>
    </xsl:template>
    <xsl:template match="Notes" mode="location">
        <dwc:locationRemarks><xsl:apply-templates/></dwc:locationRemarks>
    </xsl:template>

    <!-- Obtain sampling data from events file -->
    <!-- Contains a rather brute force method of formatting date -->
    <xsl:template match="Date">
        <xsl:variable name="date">
            <xsl:value-of select="."/>
        </xsl:variable>
        <xsl:variable name="month" select="substring-before($date, '/')"/>
        <xsl:variable name="bob" select="substring-after($date, '/')"/>
        <xsl:variable name="day" select="substring-before($bob, '/')"/>
        <xsl:variable name="year" select="substring-after($bob, '/')"/>
        <dwc:eventDate>
            <xsl:value-of select="$year"/>
            <xsl:text>-</xsl:text>
            <xsl:if test="string-length($month) lt 2">
                <xsl:text>0</xsl:text>
            </xsl:if>
            <xsl:value-of select="$month"/>
            <xsl:text>-</xsl:text>
            <xsl:if test="string-length($day) lt 2">
                <xsl:text>0</xsl:text>
            </xsl:if>
            <xsl:value-of select="$day"/>
        </dwc:eventDate>
    </xsl:template>

    <xsl:template match="VesselName" mode="event">
        <xsl:apply-templates/>
        <xsl:text>. </xsl:text>
    </xsl:template>
    <xsl:template match="CruiseNumber" mode="event">
        <xsl:text>Cruise </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>. </xsl:text>
    </xsl:template>
    <xsl:template match="DiveNumber" mode="event">
        <xsl:text>Dive </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>. </xsl:text>
    </xsl:template>
    <xsl:template match="Notes" mode="event">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Obtain filename from images file -->
    <xsl:template match="Filename">
        <dwc:materialSampleID>
            <xsl:apply-templates select="../FileStorageLocation"/>
            <xsl:value-of select="normalize-space(.)"/>
        </dwc:materialSampleID>
    </xsl:template>
    
    <xsl:template match="FileStorageLocation">
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>/</xsl:text>
    </xsl:template>

    <!-- Block everyting else -->
    <xsl:template match="*"/>


</xsl:stylesheet>

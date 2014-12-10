<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="/documents/document">
        <!-- This is the stylesheet for the transformation of supplemental files -->
        <!-- To Do: Capitalize controlled vocabulary (in Wiki, too) -->
        <mods:modsCollection xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:mods="http://www.loc.gov/mods/v3"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
            <xsl:for-each select="supplemental-files/file">
                <mods:mods>

                    <mods:titleInfo>
                        <mods:title>
                            <xsl:choose>
                                <xsl:when test="contains(archive-name, '.')">
                                    <xsl:value-of select="substring-before(archive-name, '.')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="archive-name"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </mods:title>
                    </mods:titleInfo>

                    <xsl:if test="ancestor::document/authors/author">
                        <xsl:for-each select="ancestor::document/authors/author">

                            <xsl:if test="matches(lname, '.')">
                                <mods:name type="personal" authority="local">
                                    <mods:namePart>
                                        <xsl:value-of select="lname"/>
                                        <xsl:text>, </xsl:text>
                                        <xsl:if test="fname">
                                            <xsl:value-of select="fname"/>
                                        </xsl:if>
                                        <xsl:if test="mname">
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="mname"/>
                                        </xsl:if>
                                        <xsl:if test="suffix">
                                            <xsl:text>, </xsl:text>
                                            <xsl:value-of select="suffix"/>
                                        </xsl:if>
                                    </mods:namePart>
                                    <xsl:if test="institution">
                                        <xsl:for-each select="institution">
                                        <mods:affiliation>
                                            <xsl:value-of select="."/>
                                        </mods:affiliation>
                                        </xsl:for-each>
                                    </xsl:if>
                                    <mods:role>
                                        <mods:roleTerm authority="marcrelator" type="text">
                                            <xsl:text>Author</xsl:text>
                                        </mods:roleTerm>
                                    </mods:role>
                                </mods:name>
                            </xsl:if>

                            <xsl:if test="matches(organization, '.')">
                                <mods:name type="corporate" authority="local">
                                    <mods:namePart>
                                        <xsl:value-of select="organization"/>
                                    </mods:namePart>
                                    <mods:role>
                                        <mods:roleTerm authority="marcrelator" type="text">
                                            <xsl:text>Author</xsl:text>
                                        </mods:roleTerm>
                                    </mods:role>
                                </mods:name>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>

                    <xsl:if test="ancestor::document/fields/field[@name='contributor']">
                        <xsl:for-each
                            select="ancestor::document/fields/field[@name='contributor']/value">
                            <mods:name>
                                <mods:namePart>
                                    <xsl:value-of select="."/>
                                </mods:namePart>

                                <mods:role>
                                    <mods:roleTerm authority="marcrelator" type="text">
                                        <xsl:text>Contributor</xsl:text>
                                    </mods:roleTerm>
                                </mods:role>
                            </mods:name>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:for-each select="mime-type">
                        <mods:typeOfResource>
                            <!-- text, cartographic, notated music, sound recording-musical, sound recording-nonmusical, sound recording, still image, moving image, three dimensional object, software, multimedia, mixed material  -->
                            <xsl:choose>

                                <xsl:when test="contains(., 'image')">
                                    <xsl:text>still image</xsl:text>
                                </xsl:when>

                                <xsl:when test="contains(., 'video')">
                                    <xsl:text>moving image</xsl:text>
                                </xsl:when>

                                <xsl:when
                                    test="contains(., 'msword') or contains(., 'pdf') or contains(., 'rtf') or contains(., 'zip') or contains(., 'text') or contains(., 'excel') or contains(., 'sheet')">
                                    <xsl:text>text</xsl:text>
                                </xsl:when>

                                <xsl:when
                                    test="contains(., 'powerpoint') or contains(., 'presentation')">
                                    <xsl:text>mixed material</xsl:text>
                                </xsl:when>

                                <xsl:otherwise>
                                    <xsl:text>text</xsl:text>
                                </xsl:otherwise>

                            </xsl:choose>
                        </mods:typeOfResource>
                    </xsl:for-each>

                    <xsl:for-each select="mime-type">
                        <mods:genre authority="aat">
                            <xsl:choose>

                                <xsl:when test="contains(., 'image')">
                                    <xsl:text>photographs</xsl:text>
                                </xsl:when>

                                <xsl:when test="contains(., 'video')">
                                    <xsl:text>moving images</xsl:text>
                                </xsl:when>

                                <xsl:when
                                    test="contains(., 'msword') or contains(., 'pdf') or contains(., 'rtf') or contains(., 'text') or contains(., 'excel') or contains(., 'sheet')">
                                    <xsl:text>texts (document genres)</xsl:text>
                                </xsl:when>

                                <xsl:when
                                    test="contains(., 'powerpoint') or contains(., 'presentation') or contains(., 'zip')">
                                    <xsl:text>mixed media</xsl:text>
                                </xsl:when>

                                <xsl:otherwise>
                                    <xsl:text>text</xsl:text>
                                </xsl:otherwise>

                            </xsl:choose>
                        </mods:genre>
                    </xsl:for-each>


                    <mods:physicalDescription>
                        <mods:form authority="marcform">
                            <!-- braille, electronic, microfiche, microfilm, print, large print  -->
                            <xsl:text>electronic</xsl:text>
                        </mods:form>
                    </mods:physicalDescription>

                    <xsl:if test="description">
                        <mods:abstract>
                            <xsl:value-of select="description"/>
                        </mods:abstract>
                    </xsl:if>
                    
                    <xsl:if test="upload-name">
                            <mods:note>
                                <xsl:text>Upload name: </xsl:text>
                                <xsl:value-of select="upload-name"/>
                            </mods:note>
                    </xsl:if>

                    <xsl:if test="ancestor::document/subject-areas/subject-area">
                        <xsl:for-each select="ancestor::document/subject-areas/subject-area">
                            <mods:subject>
                                <mods:topic authority="lcsh">
                                    <xsl:value-of select="."/>
                                </mods:topic>
                            </mods:subject>
                        </xsl:for-each>
                    </xsl:if>

                    <xsl:if test="ancestor::document/keywords/keyword">
                        <xsl:for-each select="ancestor::document/keywords/keyword">
                            <mods:subject>
                                <mods:topic>
                                    <xsl:value-of select="."/>
                                </mods:topic>
                            </mods:subject>
                        </xsl:for-each>
                    </xsl:if>

                    <xsl:if test="ancestor::document/disciplines/discipline">
                        <xsl:for-each select="ancestor::document/disciplines/discipline">
                            <mods:subject>
                                <mods:topic>
                                    <xsl:value-of select="."/>
                                </mods:topic>
                            </mods:subject>
                        </xsl:for-each>
                    </xsl:if>

                    <mods:relatedItem type="host">
                        <mods:titleInfo>
                            <mods:title>
                                <xsl:value-of select="ancestor::document/title"/>
                            </mods:title>
                        </mods:titleInfo>

                        <mods:originInfo>
                            <xsl:if test="ancestor::document/fields/field[@name='publisher']">
                                <mods:publisher>
                                    <xsl:value-of
                                        select="ancestor::document/fields/field[@name='publisher']/value"
                                    />
                                </mods:publisher>
                            </xsl:if>

                            <xsl:choose>
                                <xsl:when
                                    test="ancestor::document/fields/field[@name='date_accepted']/value">
                                    <mods:dateIssued encoding="w3cdtf">
                                        <xsl:value-of
                                            select="substring-before(ancestor::document/fields/field[@name='date_accepted']/value, 'T')"/>
                                    </mods:dateIssued>
                                </xsl:when>

                                <xsl:otherwise>
                                    <xsl:if test="ancestor::document/publication-date">
                                        <mods:dateIssued encoding="w3cdtf">
                                            <xsl:value-of
                                                select="substring-before(ancestor::document/publication-date, 'T')"
                                            />
                                        </mods:dateIssued>
                                    </xsl:if>
                                </xsl:otherwise>

                            </xsl:choose>
                        </mods:originInfo>
                        <xsl:if test="ancestor::document/fields/field[@name='external_url']/value">
                        <mods:identifier type="hdl">
                            <xsl:value-of
                                select="ancestor::document/fields/field[@name='external_url']/value"/>
                        </mods:identifier>
                        </xsl:if>
                    </mods:relatedItem>

                </mods:mods>
            </xsl:for-each>
        </mods:modsCollection>

    </xsl:template>

</xsl:stylesheet>
<!-- Last updated by Sarah Sweeney 2014-04-07 -->

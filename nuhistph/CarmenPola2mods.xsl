<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="/DirectoryMetadata">
        <mods:modsCollection xmlns:mods="http://www.loc.gov/mods/v3"
            xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
            <xsl:for-each select="FileSet">
                <mods:mods xmlns:mods="http://www.loc.gov/mods/v3"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">

                    <xsl:choose>

                        <xsl:when
                            test="starts-with(Description/Metadata[@name='nuhistph.Title'], 'The ') or starts-with(Description/Metadata[@name='nuhistph.Title'], 'the ')">
                            <mods:titleInfo>
                                <mods:nonSort>
                                    <xsl:text>The</xsl:text>
                                </mods:nonSort>
                                <mods:title>
                                    <xsl:value-of
                                        select="substring-after(Description/Metadata[@name='nuhistph.Title'], ' ')"
                                    />
                                </mods:title>
                            </mods:titleInfo>
                        </xsl:when>

                        <xsl:when
                            test="starts-with(Description/Metadata[@name='nuhistph.Title'], 'A ') or starts-with(Description/Metadata[@name='nuhistph.Title'], 'a ')">
                            <mods:titleInfo>
                                <mods:nonSort>
                                    <xsl:text>A</xsl:text>
                                </mods:nonSort>
                                <mods:title>
                                    <xsl:value-of
                                        select="substring-after(Description/Metadata[@name='nuhistph.Title'], ' ')"
                                    />
                                </mods:title>
                            </mods:titleInfo>
                        </xsl:when>

                        <xsl:when
                            test="starts-with(Description/Metadata[@name='nuhistph.Title'], 'An ') or starts-with(Description/Metadata[@name='nuhistph.Title'], 'an ')">
                            <mods:titleInfo>
                                <mods:nonSort>
                                    <xsl:text>An</xsl:text>
                                </mods:nonSort>
                                <mods:title>
                                    <xsl:value-of
                                        select="substring-after(Description/Metadata[@name='nuhistph.Title'], ' ')"
                                    />
                                </mods:title>
                            </mods:titleInfo>
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:for-each select="Description/Metadata[@name='nuhistph.Title']">
                                <mods:titleInfo>
                                    <mods:title>
                                        <xsl:value-of select="."/>
                                    </mods:title>
                                </mods:titleInfo>
                            </xsl:for-each>
                        </xsl:otherwise>

                    </xsl:choose>

                    <xsl:if test="Description/Metadata[@name='nuhistph.Creator']!='Unknown'">
                        <xsl:for-each select="Description/Metadata[@name='nuhistph.Creator']">
                            <mods:name authority="local">
                                <mods:namePart>
                                    <xsl:value-of select="."/>
                                </mods:namePart>
                            </mods:name>
                        </xsl:for-each>
                    </xsl:if>

                    <xsl:choose>
                        <xsl:when test="contains(FileName, 'jpg')">
                            <mods:typeOfResource>
                                <xsl:text>still image</xsl:text>
                            </mods:typeOfResource>

                            <mods:genre authority="aat">
                                <xsl:text>photographs</xsl:text>
                            </mods:genre>
                        </xsl:when>
                        <xsl:when test="contains(FileName, 'pdf')">
                            <mods:typeOfResource>
                                <xsl:text>text</xsl:text>
                            </mods:typeOfResource>

                            <mods:genre authority="aat">
                                <xsl:text>texts (document genres)</xsl:text>
                            </mods:genre>
                        </xsl:when>
                    </xsl:choose>

                    <mods:originInfo>
                        <xsl:if test="Description/Metadata[@name='nuhistph.DateCreated']">
                            <mods:dateCreated encoding="w3cdtf" keyDate="yes">
                                <xsl:value-of
                                    select="Description/Metadata[@name='nuhistph.DateCreated']"/>
                            </mods:dateCreated>
                        </xsl:if>
                        <!--
                        <xsl:if test="Description/Metadata[@name='nuhistph.dateTimeCreated']">
                            <mods:dateIssued>
                                <xsl:value-of
                                    select="Description/Metadata[@name='nuhistph.dateTimeCreated']"
                                />
                            </mods:dateIssued>
                        </xsl:if>
                        -->
                    </mods:originInfo>

                    <xsl:if test="contains(FileName, 'pdf')">
                        <mods:language>
                            <mods:languageTerm authority="iso639-2b">
                                <xsl:text>eng</xsl:text>
                            </mods:languageTerm>
                        </mods:language>
                    </xsl:if>

                    <mods:physicalDescription>
                        <!-- MARC form if items term list: braille, electronic, microfiche, microfilm, print, large print  -->
                        <mods:form authority="marcform">
                            <xsl:text>electronic</xsl:text>
                        </mods:form>

                        <mods:digitalOrigin>
                            <xsl:text>reformatted digital</xsl:text>
                        </mods:digitalOrigin>
                    </mods:physicalDescription>

                    <xsl:if test="Description/Metadata[@name='nuhistph.RelationIsPartOf']">
                        <xsl:for-each
                            select="Description/Metadata[@name='nuhistph.RelationIsPartOf']">

                            <mods:relatedItem type="host">
                                <mods:titleInfo>
                                    <mods:title>
                                        <xsl:value-of select="substring-before(., ' (')"/>
                                    </mods:title>
                                </mods:titleInfo>

                                <xsl:choose>
                                    <xsl:when
                                        test="contains(../Metadata[@name='nuhistph.RightsRightsHolder'], 'Copyright')">
                                        <xsl:for-each
                                            select="Description/Metadata[@name='nuhistph.RightsRightsHolder']">
                                            <mods:note type="provenance">
                                                <xsl:value-of
                                                  select="ancestor::Description/Metadata[@name='nuhistph.Provenance']"
                                                />
                                            </mods:note>
                                        </xsl:for-each>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:for-each
                                            select="../Metadata[@name='nuhistph.RightsRightsHolder']">
                                            <mods:note type="provenance">
                                                <xsl:value-of select="."/>
                                            </mods:note>
                                        </xsl:for-each>
                                    </xsl:otherwise>
                                </xsl:choose>


                            </mods:relatedItem>

                        </xsl:for-each>
                    </xsl:if>
                    
                        <xsl:for-each select="Description/Metadata[@name='nuhistph.Description']">
                            <xsl:if test=". !=''">
                            <mods:abstract>
                                <xsl:value-of select="."/>
                            </mods:abstract>
                            </xsl:if>
                        </xsl:for-each>

                    <xsl:if test="Description/Metadata[@name='nuhistph.Subject']">
                        <xsl:for-each select="Description/Metadata[@name='nuhistph.Subject']">
                            <mods:subject>
                                <mods:topic authority="lcsh">
                                    <xsl:value-of select="."/>
                                </mods:topic>
                            </mods:subject>
                        </xsl:for-each>
                    </xsl:if>

                    <xsl:if test="Description/Metadata[@name='nuhistph.CoverageSpatial']">
                        <xsl:for-each
                            select="Description/Metadata[@name='nuhistph.CoverageSpatial']">
                            <mods:subject>
                                <mods:geographic authority="local">
                                    <xsl:value-of select="."/>
                                </mods:geographic>
                            </mods:subject>
                        </xsl:for-each>
                    </xsl:if>

                    <xsl:if
                        test="Description/Metadata[@name='nuhistph.subjectHeadingGroupNameTerm']">
                        <xsl:for-each
                            select="Description/Metadata[@name='nuhistph.subjectHeadingGroupNameTerm']">
                            <mods:subject>
                                <mods:name type="corporate" authority="local">
                                    <mods:namePart>
                                        <xsl:value-of select="."/>
                                    </mods:namePart>
                                </mods:name>
                            </mods:subject>
                        </xsl:for-each>
                    </xsl:if>

                    <xsl:if
                        test="Description/Metadata[@name='nuhistph.subjectHeadingPersonalNameTerm']">
                        <xsl:for-each
                            select="Description/Metadata[@name='nuhistph.subjectHeadingPersonalNameTerm']">
                            <mods:subject>
                                <mods:name type="personal" authority="local">
                                    <mods:namePart>
                                        <xsl:value-of select="."/>
                                    </mods:namePart>
                                </mods:name>
                            </mods:subject>
                        </xsl:for-each>
                    </xsl:if>



                    <xsl:if
                        test="contains(Description/Metadata[@name='nuhistph.RelationIsPartOf'], 'Box')">
                        <mods:relatedItem type="original">
                            <xsl:choose>
                                <xsl:when test="contains(FileName, '.jpg')">
                                    <mods:typeOfResource>
                                        <xsl:text>still image</xsl:text>
                                    </mods:typeOfResource>
                                </xsl:when>
                                <xsl:when test="contains(FileName, '.pdf')">
                                    <mods:typeOfResource>
                                        <xsl:text>text</xsl:text>
                                    </mods:typeOfResource>
                                </xsl:when>
                            </xsl:choose>

                            <xsl:for-each
                                select="Description/Metadata[@name='nuhistph.RelationIsFormatOf']">
                                <xsl:choose>
                                    <!--<xsl:when test="contains(., 'White Document') or contains(., 'Color Document') or contains(ancestor::FileSet/Description/Metadata[@name='nuhistph.RightsRightsHolder'], 'Document')">
                                        <mods:genre authority="aat">
                                            <xsl:text>texts (document genres)</xsl:text>
                                        </mods:genre>
                                    </xsl:when>-->
                                    <xsl:when test="contains(., 'White Print')">
                                        <mods:genre authority="aat">
                                            <xsl:text>black-and-white prints (photographs)</xsl:text>
                                        </mods:genre>
                                    </xsl:when>
                                    <xsl:when test="contains(., 'Color Negative')">
                                        <mods:genre authority="aat">
                                            <xsl:text>color negatives</xsl:text>
                                        </mods:genre>
                                    </xsl:when>
                                    <xsl:when test="contains(., 'Color Print')">
                                        <mods:genre authority="aat">
                                            <xsl:text>color prints (photographs)</xsl:text>
                                        </mods:genre>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:for-each>

                            <xsl:if test="contains(FileName, 'pdf')">
                                <mods:genre authority="aat">
                                    <xsl:text>texts (document genres)</xsl:text>
                                </mods:genre>
                            </xsl:if>


                            <!--                            <xsl:if test="contains(FileName, 'jpg')">
                                <mods:genre authority="aat">
                                    <xsl:text>photographs</xsl:text>
                                </mods:genre>
                            </xsl:if>

                            <xsl:if test="contains(FileName, 'pdf')">
                                <mods:genre authority="aat">
                                    <xsl:text>texts (document genres)</xsl:text>
                                </mods:genre>
                            </xsl:if>-->

                            <xsl:if test="Description/Metadata[@name='nuhistph.RelationIsFormatOf']">
                                <mods:physicalDescription>
                                    <xsl:for-each
                                        select="Description/Metadata[@name='nuhistph.RelationIsFormatOf']">
                                        <mods:extent>
                                            <xsl:value-of select="."/>
                                        </mods:extent>
                                    </xsl:for-each>
                                </mods:physicalDescription>
                            </xsl:if>


                            <xsl:if test="contains(FileName, 'pdf')">
                                <mods:identifier>
                                    <xsl:value-of
                                        select="substring-before((replace(FileName, '[\\]', '')), '.pdf')"
                                    />
                                </mods:identifier>
                            </xsl:if>
                            <xsl:if test="contains(FileName, 'jpg')">
                                <mods:identifier>
                                    <xsl:value-of
                                        select="substring-before((replace(FileName, '[\\]', '')), '.jpg')"
                                    />
                                </mods:identifier>
                            </xsl:if>

                            <mods:location>
                                <mods:physicalLocation>
                                    <xsl:value-of
                                        select="Description/Metadata[@name='nuhistph.RelationIsPartOf']"
                                    />
                                </mods:physicalLocation>
                            </mods:location>

                        </mods:relatedItem>

                    </xsl:if>

                    <xsl:if test="FileName">
                        <mods:identifier type="file_name">
                            <xsl:value-of select="replace(FileName, '[\\]', '')"/>
                        </mods:identifier>
                    </xsl:if>

                </mods:mods>
            </xsl:for-each>
        </mods:modsCollection>
    </xsl:template>
</xsl:stylesheet>

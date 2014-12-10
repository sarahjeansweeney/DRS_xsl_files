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
                    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd"
                    ID="{substring-before(FileName, '\')}">

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
                            <xsl:choose>
                                <xsl:when test="contains(., 'Bouvé, Marjorie, 1879-1970')">
                                    <mods:name authority="local">
                                        <mods:namePart>Bouvé, Marjorie</mods:namePart>
                                        <mods:namePart type="date">1879-1970</mods:namePart>
                                    </mods:name>
                                </xsl:when>
                                <xsl:otherwise>
                                    <mods:name authority="local">
                                        <mods:namePart>
                                            <xsl:value-of select="."/>
                                        </mods:namePart>
                                    </mods:name>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:if>

                    <!-- RELATION IS FORMAT OF -->

                    <mods:typeOfResource>
                        <xsl:call-template name="typeofresource"/>
                    </mods:typeOfResource>

                    <xsl:call-template name="genre"/>


                    <!--                    <xsl:choose>
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
                    </xsl:choose>-->

                    <xsl:if test="Description/Metadata[@name='nuhistph.DateCreated']">
                        <mods:originInfo>

                            <mods:dateCreated encoding="w3cdtf" keyDate="yes">
                                <xsl:value-of
                                    select="Description/Metadata[@name='nuhistph.DateCreated']"/>
                            </mods:dateCreated>

                        </mods:originInfo>
                    </xsl:if>

                    <!-- REMOVED LANGUAGE -->

                    <mods:physicalDescription>
                        <!-- MARC form if items term list: braille, electronic, microfiche, microfilm, print, large print  -->
                        <mods:form authority="marcform">
                            <xsl:text>electronic</xsl:text>
                        </mods:form>

                        <mods:digitalOrigin>
                            <xsl:text>reformatted digital</xsl:text>
                        </mods:digitalOrigin>
                    </mods:physicalDescription>



                    <xsl:for-each select="Description/Metadata[@name='nuhistph.Description']">
                        <xsl:if test=". !=''">
                            <mods:abstract>
                                <xsl:value-of select="."/>
                            </mods:abstract>
                        </xsl:if>
                    </xsl:for-each>


                    <xsl:if test="Description/Metadata[@name='nuhistph.Provenance']">
                        <xsl:for-each select="Description/Metadata[@name='nuhistph.Provenance']">
                            <mods:note type="provenance">
                                <xsl:value-of select="."/>
                            </mods:note>
                        </xsl:for-each>
                    </xsl:if>

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

                    <!--                    <xsl:if
                        test="contains(Description/Metadata[@name='nuhistph.RelationIsPartOf'], 'M89')">
                        <xsl:for-each
                            select="Description/Metadata[@name='nuhistph.RelationIsPartOf']">
                            <mods:relatedItem type="host">
                                <mods:titleInfo>
                                    <mods:title>
                                        <xsl:text>Marjorie Bouvé Papers</xsl:text>
                                    </mods:title>
                                </mods:titleInfo>


                                <xsl:if test="Description/Metadata[@name='nuhistph.Provenance']">
                                    <xsl:for-each
                                        select="Description/Metadata[@name='nuhistph.Provenance']">
                                        <mods:note type="provenance">
                                            <xsl:value-of select="."/>
                                        </mods:note>
                                    </xsl:for-each>
                                </xsl:if>

                            </mods:relatedItem>

                        </xsl:for-each>
                    </xsl:if>-->

                    <!--                    <xsl:if
                        test="not(contains(Description/Metadata[@name='nuhistph.Title'], 'Page'))">

                        <mods:relatedItem type="host">
                            <mods:titleInfo>
                                <mods:title>
                                    <xsl:text>Marjorie Bouvé Scrapbook </xsl:text>
                                    <xsl:value-of
                                        select="substring-before(substring-after(FileName, 's'), 'p')"
                                    />
                                </mods:title>
                            </mods:titleInfo>
                            <part>
                                <extent unit="page number">
                                    <start>
                                        <xsl:value-of
                                            select="substring-before(substring-after(FileName, 'p'), 'v')"
                                        />
                                    </start>
                                </extent>
                            </part>
                        </mods:relatedItem>

                    </xsl:if>-->




                    <!--                       <mods:relatedItem type="host">
                                <mods:titleInfo>
                                    <mods:title>
                                        <xsl:text>Marjorie Bouvé Scrapbook One</xsl:text>
                                        <!-\-                    <xsl:value-of
                        select="substring-before(substring-after(FileName, 's'), 'p')"/>-\->
                                    </mods:title>
                                </mods:titleInfo>
                                <mods:part>
                                    <mods:extent unit="page number">
                                        <mods:start>
                                            <xsl:value-of
                                                select="substring-before(substring-after(FileName, 'p'), 'v')"
                                            />
                                        </mods:start>
                                    </mods:extent>
                                </mods:part>
                            </mods:relatedItem>-->

                    <!--<mods:relatedItem type="host">
                                <xsl:choose>
                                    <xsl:when
                                        test="substring-before(substring-after(FileName, 's'), 'p') ='1'">
                                        <mods:titleInfo>
                                            <mods:title>
                                                <xsl:text>Marjorie Bouvé Photo Album One</xsl:text>
                                            </mods:title>
                                        </mods:titleInfo>
                                        <titleInfo type="alternative">
                                            <mods:title>
                                                <xsl:text>Marjorie Bouvé Scrapbook One</xsl:text>
                                            </mods:title>
                                        </titleInfo>
                                    </xsl:when>
                                    <xsl:when
                                        test="substring-before(substring-after(FileName, 's'), 'p') ='3'">
                                        <mods:titleInfo>
                                            <mods:title>
                                            <xsl:text>Marjorie Bouvé Photo Album Two</xsl:text>
                                        </mods:title>
                                        </mods:titleInfo>
                                        <titleInfo type="alternative">
                                            <mods:title>
                                            <xsl:text>Marjorie Bouvé Scrapbook Three</xsl:text>
                                        </mods:title>
                                        </titleInfo>
                                    </xsl:when>
                                    <xsl:when
                                        test="contains(substring-before(substring-after(FileName, 's'), 'p'), '4')">
                                        <mods:titleInfo>
                                            <mods:title>
                                                <xsl:text>Marjorie Bouvé Scrapbook One</xsl:text>
                                                <!-\-                    <xsl:value-of
                        select="substring-before(substring-after(FileName, 's'), 'p')"/>-\->
                                            </mods:title>
                                        </mods:titleInfo>
                                    </xsl:when>
                                </xsl:choose>


                                <mods:part>
                                    <mods:extent unit="page number">
                                        <mods:start>
                                            <xsl:value-of
                                                select="substring-before(substring-after(FileName, 'p'), 'v')"
                                            />
                                        </mods:start>
                                    </mods:extent>
                                </mods:part>
                            </mods:relatedItem>-->



                    <mods:relatedItem type="original">
                        <mods:typeOfResource>
                            <xsl:call-template name="typeofresource"/>
                        </mods:typeOfResource>


                        <xsl:call-template name="genre"/>


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

                        <mods:identifier>
                            <xsl:value-of select="Description/Metadata[@name='nuhistph.Identifier']"
                            />
                        </mods:identifier>


                        <xsl:if test="Description/Metadata[@name='nuhistph.RelationIsPartOf']">
                            <mods:location>
                                <mods:physicalLocation>
                                    <!--                                    <xsl:choose>
                                        <xsl:when
                                            test="contains(Description/Metadata[@name='nuhistph.RelationIsPartOf'], '(')">
                                            <xsl:value-of
                                                select="substring-after((replace(Description/Metadata[@name='nuhistph.RelationIsPartOf'], '[()]', '')), 'Papers ')"/>

                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of
                                                select="Description/Metadata[@name='nuhistph.RelationIsPartOf']"
                                            />
                                        </xsl:otherwise>
                                    </xsl:choose>-->
                                    <xsl:text>Marjorie Bouve papers, 1892-1972 (bulk 1892-1918) (M89): </xsl:text>
                                    <xsl:value-of
                                        select="substring-after(Description/Metadata[@name='nuhistph.RelationIsPartOf'], ', ')"
                                    />
                                </mods:physicalLocation>
                            </mods:location>
                        </xsl:if>
                    </mods:relatedItem>

                    <!--<xsl:if
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
                                    <!-\-<xsl:when test="contains(., 'White Document') or contains(., 'Color Document') or contains(ancestor::FileSet/Description/Metadata[@name='nuhistph.RightsRightsHolder'], 'Document')">
                                        <mods:genre authority="aat">
                                            <xsl:text>texts (document genres)</xsl:text>
                                        </mods:genre>
                                    </xsl:when>-\->
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


                            <!-\-                            <xsl:if test="contains(FileName, 'jpg')">
                                <mods:genre authority="aat">
                                    <xsl:text>photographs</xsl:text>
                                </mods:genre>
                            </xsl:if>

                            <xsl:if test="contains(FileName, 'pdf')">
                                <mods:genre authority="aat">
                                    <xsl:text>texts (document genres)</xsl:text>
                                </mods:genre>
                            </xsl:if>-\->

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


                            <xsl:if test="Description/Metadata[@name='nuhistph.RelationIsPartOf']">
                                <mods:location>
                                    <mods:physicalLocation>
                                        <xsl:choose>
                                            <xsl:when
                                                test="contains(Description/Metadata[@name='nuhistph.RelationIsPartOf'], '(')">
                                                <xsl:value-of
                                                  select="substring-after((replace(Description/Metadata[@name='nuhistph.RelationIsPartOf'], '[()]', '')), 'Papers ')"/>

                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of
                                                  select="Description/Metadata[@name='nuhistph.RelationIsPartOf']"
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </mods:physicalLocation>
                                </mods:location>
                            </xsl:if>

                        </mods:relatedItem>

                    </xsl:if>-->

                    <xsl:if test="FileName">
                        <mods:identifier>
                            <xsl:value-of select="substring-before(FileName, '\')"/>
                        </mods:identifier>
                    </xsl:if>

                    <!--                    <xsl:if
                        test="contains(Description/Metadata[@name='nuhistph.Title'], 'Page')">
                        <part>
                            <extent unit="page number">
                                <start>
                                    <xsl:value-of
                                        select="substring-before(substring-after(FileName, 'p'), 'v')"
                                    />
                                </start>
                            </extent>
                        </part>
                    </xsl:if>-->

                </mods:mods>
            </xsl:for-each>
        </mods:modsCollection>
    </xsl:template>

    <xsl:template name="typeofresource" match="/DirectoryMetadata/FileSet/Description">
        <xsl:for-each select="Description/Metadata[@name='nuhistph.RelationIsFormatOf']">
            <xsl:if
                test="matches(., string('Postcard')) or 
                matches(., string('Scrapbook page'))">
                <xsl:text>mixed material</xsl:text>
            </xsl:if>

            <xsl:if test="matches(., string('Song sheet'))">
                <xsl:text>notated music</xsl:text>
            </xsl:if>

            <xsl:if
                test="matches(., string('Hand-drawn advertisement')) or 
                matches(., string('Photograph and Hand-drawn illustration')) or
                matches(., string('Black and White Print')) or
                matches(., string('Black and White Prints')) or
                matches(., string('Bookplate')) or
                matches(., string('Cyanotype Print')) or
                matches(., string('Paper decoration')) or
                matches(., string('Hand-drawn illustration')) or
                matches(., string('Printed illustration')) or
                matches(., string('Paper silhouette')) or 
                matches(., string('Pencil sketch'))">
                <xsl:text>still image</xsl:text>
            </xsl:if>

            <xsl:if
                test="matches(., string('Booklet')) or 
                matches(., string('Printed booklet')) or
                matches(., string('Newspaper clipping')) or
                matches(., string('Handwritten Document')) or
                matches(., string('Typed document')) or
                matches(., string('Printed booklet')) or
                matches(., string('Printed form')) or
                matches(., string('Menu')) or
                matches(., string('Newspaper')) or
                matches(., string('Printed page')) or
                matches(., string('Pamphlet')) or
                matches(., string('Printed pamphlet')) or
                matches(., string('Program')) or
                matches(., string('Programs')) or
                matches(., string('Paper receipt')) or
                matches(., string('Printed receipt')) or
                matches(., string('Report card')) or
                matches(., string('Telegram')) or
                matches(., string('Notecard')) or
                matches(., string('Notepaper')) or
                matches(., string('Printed card')) or
                matches(., string('Scorecard')) or
                matches(., string('Social Stationary')) or
                matches(., string('^Stationary$'))">
                <xsl:text>text</xsl:text>
            </xsl:if>

            <xsl:if
                test="matches(., string('Paper money')) or 
                matches(., string('Fabric flower')) or
                matches(., string('Paper and dried flowers')) or
                matches(., string('Wooden cane')) or
                matches(., string('Fabric shape')) or
                matches(., string('Dance card')) or
                matches(., string('Feather')) or
                matches(., string('Fabric flag')) or
                matches(., string('Paper flag')) or
                matches(., string('Envelope ')) or
                matches(., string('Invitation card')) or
                matches(., string('Scrapbook cover')) or
                matches(., string('Paper tag')) or
                matches(., string('Printed target')) or
                matches(., string('Printed ticket')) or
                matches(., string('Ticket'))">
                <xsl:text>three dimensional object</xsl:text>
            </xsl:if>

        </xsl:for-each>
    </xsl:template>

    <xsl:template name="genre" match="/DirectoryMetadata/FileSet/Description"
        xmlns:mods="http://www.loc.gov/mods/v3">
        <xsl:for-each select="Description/Metadata[@name='nuhistph.RelationIsFormatOf']">

            <xsl:if test="matches(., string('Hand-drawn advertisement'))">
                <mods:genre authority="aat">
                    <xsl:text>advertisements</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Paper money')) ">
                <mods:genre authority="aat">
                    <xsl:text>American paper money</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Fabric flower')) or matches(., string
                ('Paper and dried flowers'))">
                <mods:genre authority="aat">
                    <xsl:text>artificial flowers</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Paper and dried flowers'))">
                <mods:genre authority="aat">
                    <xsl:text>flower (plant material)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Photograph and Hand-drawn illustration'))">
                <mods:genre authority="aat">
                    <xsl:text>black-and-white photographs</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Photograph and Hand-drawn illustration'))">
                <mods:genre authority="aat">
                    <xsl:text>drawings (visual works)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Black and White Print')) or 
                matches(., string('Black and White Prints'))">
                <mods:genre authority="aat">
                    <xsl:text>black-and-white prints (photographs)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Booklet')) or 
                matches(., string('Printed booklet'))">
                <mods:genre authority="aat">
                    <xsl:text>booklets</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string ('Bookplate'))">
                <mods:genre authority="aat">
                    <xsl:text>bookplates</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Wooden cane'))">
                <mods:genre authority="aat">
                    <xsl:text>canes (walking sticks)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Newspaper clipping'))">
                <mods:genre authority="aat">
                    <xsl:text>clippings (information artifacts)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Fabric shape'))">
                <mods:genre authority="aat">
                    <xsl:text>cloth</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('^Stationary$')) or 
                matches(., string ('Social Stationary'))">
                <mods:genre authority="aat">
                    <xsl:text>correspondence</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Paper decoration'))">
                <mods:genre authority="aat">
                    <xsl:text>cutouts</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Cyanotype Print'))">
                <mods:genre authority="aat">
                    <xsl:text>cyanotypes (photographic prints)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Dance card'))">
                <mods:genre authority="aat">
                    <xsl:text>dance cards</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Handwritten Document')) or 
                matches(., string('Typed document')) or 
                matches(., string('Printed card'))">
                <mods:genre authority="aat">
                    <xsl:text>documents</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Hand-drawn illustration')) or 
                matches(., string('Printed illustration'))">
                <mods:genre authority="aat">
                    <xsl:text>drawings (visual works)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Envelope '))">
                <mods:genre authority="aat">
                    <xsl:text>envelopes</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Feather'))">
                <mods:genre authority="aat">
                    <xsl:text>feather (material)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Fabric flag')) or 
                matches(., string('Paper flag'))">
                <mods:genre authority="aat">
                    <xsl:text>flags</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Printed form'))">
                <mods:genre authority="aat">
                    <xsl:text>forms (documents)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string ('Hair'))">
                <mods:genre authority="aat">
                    <xsl:text>hair</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Invitation card'))">
                <mods:genre authority="aat">
                    <xsl:text>invitations</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string ('Menu'))">
                <mods:genre authority="aat">
                    <xsl:text>menus</xsl:text>
                </mods:genre>
            </xsl:if>




            <xsl:if test="matches(., string ('Newspaper'))">
                <mods:genre authority="aat">
                    <xsl:text>newspapers</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Notecard')) or 
                matches(., string ('Notepaper'))">
                <mods:genre authority="aat">
                    <xsl:text>notes</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Printed page'))">
                <mods:genre authority="aat">
                    <xsl:text>pages</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Printed pamphlet')) or 
                matches(., string ('Pamphlet'))">
                <mods:genre authority="aat">
                    <xsl:text>pamphlets</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string ('Postcard'))">
                <mods:genre authority="aat">
                    <xsl:text>postcards</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Program')) or 
                matches(., string('Programs'))">
                <mods:genre authority="aat">
                    <xsl:text>programs (documents)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Printed receipt')) or 
                matches(., string ('Paper receipt'))">
                <mods:genre authority="aat">
                    <xsl:text>receipts (financial records)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Report card'))">
                <mods:genre authority="aat">
                    <xsl:text>report cards</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string ('Scorecard'))">
                <mods:genre authority="aat">
                    <xsl:text>scorebooks</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Scrapbook cover'))">
                <mods:genre authority="aat">
                    <xsl:text>scrapbooks</xsl:text>
                </mods:genre>
                <mods:genre authority="aat">
                    <xsl:text>covers (overlying objects)</xsl:text>
                </mods:genre>
            </xsl:if>

            <xsl:if test="matches(., string ('Scrapbook page'))">
                <mods:genre authority="aat">
                    <xsl:text>scrapbooks</xsl:text>
                </mods:genre>
                <mods:genre authority="aat">
                    <xsl:text>pages</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Song sheet'))">
                <mods:genre authority="aat">
                    <xsl:text>sheet music</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Paper silhouette'))">
                <mods:genre authority="aat">
                    <xsl:text>silhouettes</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Pencil sketch'))">
                <mods:genre authority="aat">
                    <xsl:text>sketches</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Paper tag'))">
                <mods:genre authority="aat">
                    <xsl:text>tags</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string('Printed target'))">
                <mods:genre authority="aat">
                    <xsl:text>targets (sports equipment)</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if test="matches(., string ('Telegram'))">
                <mods:genre authority="aat">
                    <xsl:text>telegrams</xsl:text>
                </mods:genre>
            </xsl:if>



            <xsl:if
                test="matches(., string('Printed ticket')) or 
                matches(., string ('Ticket'))">
                <mods:genre authority="aat">
                    <xsl:text>tickets</xsl:text>
                </mods:genre>
            </xsl:if>

        </xsl:for-each>

        <xsl:if test="contains(Description/Metadata[@name='nuhistph.Title'], 'photo album')">
            <mods:genre authority="aat">
                <xsl:text>photograph albums</xsl:text>
            </mods:genre>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
<!-- created by sjs; last updated 8/20/2013 -->

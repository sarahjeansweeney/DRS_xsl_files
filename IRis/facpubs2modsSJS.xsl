<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="/documents/document">

        <mods:mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:mods="http://www.loc.gov/mods/v3"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">

            <!-- This is the stylesheet for the transformation of faculty publications and general IRis works (any xml file in the archive that does not have "aes", "art_book", "books", "diss", "theses", or "honors_projects" in the file name) -->
            <!-- To Do: Capitalize controlled vocabulary (in Wiki, too) -->

            <!-- BEPRESS : <title> -->

            <mods:titleInfo>
                <xsl:choose>
                    <xsl:when test="starts-with(title, 'The ')">
                        <mods:nonSort>
                            <xsl:text>The</xsl:text>
                        </mods:nonSort>
                        <mods:title>
                            <xsl:choose>
                                <xsl:when test="contains(title, ':')">
                                    <xsl:value-of select="substring-before(substring-after(title, 'The '), ':')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring-after(title, 'The ')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </mods:title>
                        <xsl:if test="contains(title, ': ')">
                            <mods:subTitle>
                                <xsl:value-of select="substring-after(title, ': ')"/>
                            </mods:subTitle>
                        </xsl:if>
                    </xsl:when>
                    
                    <xsl:when test="starts-with(title, 'A ')">
                        <mods:nonSort>
                            <xsl:text>A</xsl:text>
                        </mods:nonSort>
                        <mods:title>
                            <xsl:choose>
                                <xsl:when test="contains(title, ':')">
                                    <xsl:value-of select="substring-before(substring-after(title, 'A '), ':')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring-after(title, 'A ')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </mods:title>
                        <xsl:if test="contains(title, ': ')">
                            <mods:subTitle>
                                <xsl:value-of select="substring-after(title, ': ')"/>
                            </mods:subTitle>
                        </xsl:if>
                    </xsl:when>
                    
                    <xsl:when test="starts-with(title, 'An ')">
                        <mods:nonSort>
                            <xsl:text>An</xsl:text>
                        </mods:nonSort>
                        <mods:title>
                            <xsl:choose>
                                <xsl:when test="contains(title, ':')">
                                    <xsl:value-of select="substring-before(substring-after(title, 'An '), ':')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring-after(title, 'An ')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </mods:title>
                        <xsl:if test="contains(title, ': ')">
                            <mods:subTitle>
                                <xsl:value-of select="substring-after(title, ': ')"/>
                            </mods:subTitle>
                        </xsl:if>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="contains(title, ': ')">
                                <mods:title>
                                    <xsl:value-of select="substring-before(title, ':')"/>
                                </mods:title>
                                <mods:subTitle>
                                    <xsl:value-of select="substring-after(title, ': ')"/>
                                </mods:subTitle>
                            </xsl:when>
                            <xsl:otherwise>
                                <mods:title>
                                    <xsl:value-of select="title"/>
                                </mods:title>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </xsl:otherwise>
                </xsl:choose>
                
                
            </mods:titleInfo>

            <!-- BEPRESS : <field name="alt_title" type="string"> -->

            <xsl:if test="fields/field[@name='alt_title']">
                <mods:titleInfo type="alternative">
                    <mods:title>
                        <xsl:value-of select="fields/field[@name='alt_title']/value"/>
                    </mods:title>
                </mods:titleInfo>
            </xsl:if>

            <!-- BEPRESS : <authors> <author> <email> <institution> <lname> <fname> <mname> <suffix>  -->

            <xsl:if test="authors/author">
                <xsl:for-each select="authors/author">

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

            <!-- BEPRESS : <field name="contributor" type="string" list="true"> -->

            <xsl:if test="fields/field[@name='contributor']">
                <xsl:for-each select="fields/field[@name='contributor']/value">
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

            <!-- BEPRESS : <type> -->

            <mods:typeOfResource>
            <!-- text, cartographic, notated music, sound recording-musical, sound recording-nonmusical, sound recording, still image, moving image, three dimensional object, software, multimedia, mixed material  -->
                <xsl:choose>
                    <xsl:when test="document-type='still_image'">
                        <xsl:text>still image</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>text</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </mods:typeOfResource>

            <!-- BEPRESS : <document-type> -->

            <mods:genre authority="aat">
                <xsl:choose>
                    <xsl:when test="document-type='article'">
                        <xsl:text>articles</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='Article'">
                        <xsl:text>articles</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='bookreview'">
                        <xsl:text>reviews</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='conference'">
                        <xsl:text>proceedings </xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='dataset'">
                        <xsl:text>data</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='ephemera'">
                        <xsl:text>printed ephemera</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='event'">
                        <xsl:text>events</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='newsletter'">
                        <xsl:text>newsletters</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='presentation'">
                        <xsl:text>presentations</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='press_release'">
                        <xsl:text>press releases</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='report'">
                        <xsl:text>reports</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='annual_report'">
                        <xsl:text>annual reports</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='still_image'">
                        <xsl:text>photographs</xsl:text>
                    </xsl:when>

                    <xsl:when test="document-type='text'">
                        <xsl:text>texts</xsl:text>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:text>other</xsl:text>
                    </xsl:otherwise>

                </xsl:choose>
            </mods:genre>

            <mods:originInfo>
                <!-- BEPRESS : <field name="publisher" type="string"> -->
                <xsl:if test="fields/field[@name='publisher']">
                    <mods:publisher>
                        <xsl:value-of select="fields/field[@name='publisher']/value"/>
                    </mods:publisher>
                </xsl:if>


                <!-- PATRICK: The code in question is the xsl:choose below -->

                <!-- BEPRESS : <publication-date | rights_information> -->
                <xsl:choose>

                    <xsl:when
                        test="contains(fields/field[@name='rights_information']/value, '1') or contains(fields/field[@name='rights_information']/value, '2')">
                        <mods:copyrightDate encoding="w3cdtf" keyDate="yes">
                            <xsl:value-of
                                select="replace(fields/field[@name='rights_information']/value, '.(\d{4,4})?', '$1')"/>
                            <!-- when there are multiple 4 digit numbers in this field, they are repeated in the transformation with no spaces. needs to be fixed. -->
                        </mods:copyrightDate>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:if test="publication-date">
                            <mods:dateIssued encoding="w3cdtf" keyDate="yes">
                                <xsl:value-of select="substring-before(publication-date, 'T')"/>
                            </mods:dateIssued>
                        </xsl:if>
                    </xsl:otherwise>

                </xsl:choose>
            </mods:originInfo>

            <!-- BEPRESS : not mapped from IRis -->
            <mods:language>
                <mods:languageTerm authority="iso639-2b" type="code">
                    <xsl:text>eng</xsl:text>
                </mods:languageTerm>
            </mods:language>

            <!-- BEPRESS : not mapped from IRis -->
            <mods:physicalDescription>
                <mods:form authority="marcform">
                <!-- braille, electronic, microfiche, microfilm, print, large print  -->
                    <xsl:text>electronic</xsl:text>
                </mods:form>
                <mods:digitalOrigin>
                <!-- born digital, reformatted digital, digitized microfilm, digitized other analog -->
                    <xsl:text>born digital</xsl:text>
                </mods:digitalOrigin>
            </mods:physicalDescription>

            <!-- BEPRESS : <abstract>-->

            <xsl:if test="abstract">
                <mods:abstract>
                    <xsl:value-of select="abstract"/>
                </mods:abstract>
            </xsl:if>

            <!-- BEPRESS : <field name="comments" type="string"> -->
            <xsl:if test="fields/field/@name='comments'">
                <mods:note type="comments">
                    <xsl:value-of select="fields/field[@name='comments']/value"/>
                </mods:note>
            </xsl:if>

            <!-- RIGHTS INFORMATION: Still trying to determine where this information belongs, if it belongs anywhere (access condition?). -->

            <!-- BEPRESS : <field name="rights_holder" type="string">-->

            <!--            <xsl:if test="fields/field[@name='rights_holder']">
                <mods:note type="rights_holder">
                    <xsl:value-of select="fields/field[@name='rights_holder']/value"/>
                </mods:note>
            </xsl:if>-->

            <!--BEPRESS : <field name="rights_information" type="string">-->

            <!--            <xsl:if test="fields/field[@name='rights_information']">
                <mods:note type="rights_information">
                    <xsl:value-of select="replace(fields/field[@name='rights_information']/value, '.([0-9]*)', '$1')"/>
                </mods:note>

                <mods:note type="rights_information">
                    <xsl:value-of select="fields/field[@name='rights_information']/value"/>
                </mods:note>
            </xsl:if>-->

            <!-- BEPRESS : <field name="restrictions" type="string"> -->

            <!--            <xsl:if test="fields/field[@name='restrictions']">
                <mods:note type="restrictions">
                    <xsl:value-of select="fields/field[@name='restrictions']/value"/>
                </mods:note>
            </xsl:if>-->

            <!-- BEPRESS : <subject-areas> <subject-area> -->
            <xsl:if test="subject-areas/subject-area">
                <xsl:for-each select="subject-areas/subject-area">
                    <mods:subject>
                        <mods:topic authority="lcsh">
                            <xsl:value-of select="."/>
                        </mods:topic>
                    </mods:subject>
                </xsl:for-each>
            </xsl:if>

            <!-- BEPRESS : <keywords> <keyword> -->
            <xsl:if test="keywords/keyword">
                <xsl:for-each select="keywords/keyword">
                    <mods:subject>
                        <mods:topic>
                            <xsl:value-of select="."/>
                        </mods:topic>
                    </mods:subject>
                </xsl:for-each>
            </xsl:if>

            <!-- BEPRESS :  <disciplines> <discipline> -->
            <xsl:if test="disciplines/discipline">
                <xsl:for-each select="disciplines/discipline">
                    <mods:subject>
                        <mods:topic>
                            <xsl:value-of select="."/>
                        </mods:topic>
                    </mods:subject>
                </xsl:for-each>
            </xsl:if>

            <!-- review BEPRESS : <supplemental-files> <file> <archive-name> <upload-name> <url> <mime-type> <description> -->
            <!-- Does this belong here? Is this information represented elsewhere? -->
            <!--            <xsl:if test="supplemental-files">
                <xsl:for-each select="supplemental-files/file">
                    <mods:relatedItem type="constituent">
                        <mods:titleInfo>
                            <mods:title>
                                <xsl:value-of select="upload-name"/>
                            </mods:title>
                        </mods:titleInfo>
                        <mods:titleInfo type="alternative">
                            <mods:title>
                                <xsl:value-of select="archive-name"/>
                            </mods:title>
                        </mods:titleInfo>
                        <xsl:if test="description">
                            <mods:abstract type="scope">
                                <xsl:value-of select="description"/>
                            </mods:abstract>
                        </xsl:if>
                        <mods:identifier type="hdl">
                            <xsl:value-of select="url"/>
                        </mods:identifier>
                        <mods:physicalDescription>
                            <mods:internetMediaType>
                                <xsl:value-of select="mime-type"/>
                            </mods:internetMediaType>
                        </mods:physicalDescription>
                    </mods:relatedItem>
                </xsl:for-each>
            </xsl:if>-->

            <!-- BEPRESS : <field name="external_url" type="string"> -->

            <mods:identifier type="hdl">
                <xsl:value-of
                    select="replace(fields/field[@name='external_url']/value, '^.*?&gt;(.*?)&lt;.*?$', '$1')"
                />
            </mods:identifier>
            <mods:extension displayLabel="scholarly_object">
                <scholarly_object>
                    <category>Research Publications</category>
                </scholarly_object>
            </mods:extension>
        </mods:mods>

    </xsl:template>

</xsl:stylesheet>
<!-- Last updated by Sarah Sweeney 4/2/13 -->

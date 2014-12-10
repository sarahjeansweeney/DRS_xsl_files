<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" method="xml"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/documents/document">

        <mods:mods xmlns:mods="http://www.loc.gov/mods/v3"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

            <!-- ADD BACK TO MODS:MODS xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd" -->

            <mods:titleInfo>
                <xsl:choose>
                    <xsl:when test="starts-with(title, 'The ')">
                        <mods:nonSort>
                            <xsl:text>The</xsl:text>
                        </mods:nonSort>
                        <mods:title>
                            <xsl:choose>
                                <xsl:when test="contains(title, ':')">
                                    <xsl:value-of
                                        select="substring-before(substring-after(title, 'The '), ':')"
                                    />
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
                                    <xsl:value-of
                                        select="substring-before(substring-after(title, 'A '), ':')"
                                    />
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
                                    <xsl:value-of
                                        select="substring-before(substring-after(title, 'An '), ':')"
                                    />
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

            <xsl:if test="fields/field[@name='alt_title']">
                <mods:titleInfo type="alternative">
                    <mods:title>
                        <xsl:value-of select="fields/field[@name='alt_title']/value"/>
                    </mods:title>
                </mods:titleInfo>
            </xsl:if>

            <xsl:for-each select="authors/author">
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

                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="text">Author</mods:roleTerm>
                    </mods:role>

                    <xsl:if test="institution">
                        <xsl:for-each select="institution">
                            <mods:affiliation>
                                <xsl:value-of select="."/>
                            </mods:affiliation>
                        </xsl:for-each>
                    </xsl:if>
                </mods:name>
            </xsl:for-each>

            <xsl:if test="authors/author/is-corporate">
                <mods:name type="corporate" authority="local">
                    <mods:namePart>
                        <xsl:value-of select="authors/author/is-corporate"/>
                    </mods:namePart>
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="text">Author</mods:roleTerm>
                    </mods:role>
                </mods:name>
            </xsl:if>

            <xsl:for-each select="fields/field[@name='advisor']/value">
                <mods:name type="personal" authority="local">
                    <mods:namePart>
                        <xsl:value-of select="replace(.,'^(.*)\s([A-z]+)$', '$2, $1')"/>
                    </mods:namePart>
                    <mods:role>
                        <mods:roleTerm authority="local" type="text">Advisor</mods:roleTerm>
                    </mods:role>
                </mods:name>
            </xsl:for-each>

            <xsl:for-each select="fields/field[@name='contributor']/value">
                <mods:name type="personal" authority="local">
                    <mods:namePart>
                        <xsl:value-of select="replace(.,'^(.*)\s([A-z]+)$', '$2, $1')"/>
                    </mods:namePart>
                    <mods:role>
                        <mods:roleTerm authority="local" type="text">Committee
                            member</mods:roleTerm>
                    </mods:role>
                </mods:name>
            </xsl:for-each>

            <mods:typeOfResource>text</mods:typeOfResource>


            <xsl:for-each select="document-type">
                <xsl:choose>
                    <xsl:when
                        test="matches(text(),'dissertations') or matches(text(),'dissertation') or matches(text(),'Dissertation') or matches(text(),'Dissertations') or matches(text(),'masters_thesis') or matches(text(),'masters_theses') or matches(text(),'Masters_thesis') or matches(text(),'Masters_theses')">
                        <xsl:choose>
                            <xsl:when
                                test="matches(text(),'dissertations') or matches(text(),'dissertation') or matches(text(),'Dissertation') or matches(text(),'Dissertations')">
                                <mods:genre authority="aat">
                                    <xsl:text>dissertations</xsl:text>
                                </mods:genre>
                            </xsl:when>

                            <xsl:when
                                test="matches(text(),'masters_thesis') or matches(text(),'masters_theses') or matches(text(),'Masters_thesis') or matches(text(),'Masters_theses')">
                                <mods:genre authority="aat">
                                    <xsl:text>masters theses</xsl:text>
                                </mods:genre>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="matches(text(),'doctoral_thesis')">
                        <mods:genre>
                            <xsl:text>doctoral theses</xsl:text>
                        </mods:genre>
                    </xsl:when>
                    <xsl:otherwise>
                        <mods:genre>
                            <xsl:text>other</xsl:text>
                        </mods:genre>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>

            <mods:originInfo>
                <mods:place>
                    <mods:placeTerm type="text">Boston (Mass.)</mods:placeTerm>
                </mods:place>

                <xsl:for-each select="fields/field[@name='degree_grantor']">
                    <mods:publisher>
                        <xsl:value-of select="."/>
                    </mods:publisher>
                </xsl:for-each>

                <xsl:if test="fields/field[@name='date_accepted']">
                    <mods:dateIssued encoding="w3cdtf" keyDate="yes">
                        <xsl:value-of
                            select="substring-before(fields/field[@name='date_accepted']/value, 'T00')"
                        />
                    </mods:dateIssued>
                </xsl:if>
            </mods:originInfo>


            <mods:language>
                <mods:languageTerm authority="iso639-2b" type="code">eng</mods:languageTerm>
            </mods:language>

            <mods:physicalDescription>
                <mods:form authority="marcform">electronic</mods:form>
                <mods:digitalOrigin>born digital</mods:digitalOrigin>
            </mods:physicalDescription>



            <mods:abstract>
                <xsl:value-of select="abstract"/>
            </mods:abstract>

            <xsl:if test="fields/field[@name='comments']">
                <mods:note type="comments">
                    <xsl:value-of
                        select="replace(fields/field[@name='comments']/value,'&lt;/?p&gt;','')"/>
                </mods:note>
            </xsl:if>

            <xsl:if test="fields/field[@name='custom_citation']">
                <mods:note type="citation">
                    <xsl:value-of select="fields/field[@name='custom_citation']/value"/>
                </mods:note>
            </xsl:if>



            <xsl:for-each select="keywords/keyword">
                <mods:subject>
                    <mods:topic>
                        <xsl:value-of select="."/>
                    </mods:topic>
                </mods:subject>
            </xsl:for-each>

            <xsl:for-each select="subject-areas/subject-area">
                <mods:subject>
                    <mods:topic authority="lcsh">
                        <xsl:value-of select="."/>
                    </mods:topic>
                </mods:subject>
            </xsl:for-each>

            <xsl:for-each select="disciplines/discipline">
                <mods:subject>
                    <mods:topic>
                        <xsl:value-of select="."/>
                    </mods:topic>
                </mods:subject>
            </xsl:for-each>


            <mods:identifier type="hdl">
                <xsl:value-of
                    select="replace(fields/field[@name='external_url']/value, '^.*?&gt;(.*?)&lt;.*?$', '$1')"
                />
            </mods:identifier>

            <mods:extension displayLabel="scholarly_object">
                <scholarly_object>
                    <category>Theses and Dissertations</category>
                    <xsl:for-each select="fields/field[@name='degree_grantor']">
                        <department>
                            <xsl:value-of select="."/>
                            <xsl:text>. </xsl:text>
                            <xsl:value-of select="//fields/field[@name='department']"/>
                        </department>
                    </xsl:for-each>
                    <degree>
                        <xsl:value-of select="fields/field[@name='degree_type']"/>
                    </degree>
                </scholarly_object>
            </mods:extension>
        </mods:mods>
    </xsl:template>
</xsl:stylesheet>

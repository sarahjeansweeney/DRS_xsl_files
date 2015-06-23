<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="/mods:mods">
        <mods:mods xmlns:mods="http://www.loc.gov/mods/v3" xmlns:METS="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
            <xsl:copy-of select="mods:titleInfo"/>
            <xsl:copy-of select="mods:name"/>
            <xsl:copy-of select="mods:typeOfResource"/>
            <xsl:copy-of select="mods:genre"/>
            <xsl:if test="mods:originInfo">
                <mods:originInfo>
                    <xsl:choose>
                    <xsl:when test="mods:originInfo/mods:dateIssued[3]">
                        <xsl:copy-of select="mods:originInfo/mods:dateIssued[2]"/>
                        <xsl:copy-of select="mods:originInfo/mods:dateIssued[3]"/>
                    </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="mods:originInfo/mods:dateIssued"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:copy-of select="mods:originInfo/mods:dateCreated"/>
                    <xsl:copy-of select="mods:originInfo/mods:dateCaptured"/>
                    <xsl:copy-of select="mods:originInfo/mods:dateValid"/>
                    <xsl:copy-of select="mods:originInfo/mods:dateModified"/>
                    <xsl:copy-of select="mods:originInfo/mods:copyrightDate"/>
                    <xsl:copy-of select="mods:originInfo/mods:dateOther"/>
                    <xsl:copy-of select="mods:originInfo/mods:edition"/>
                    <xsl:copy-of select="mods:originInfo/mods:issuance"/>
                    <xsl:copy-of select="mods:originInfo/mods:frequency"/>
                    <xsl:copy-of select="mods:originInfo/mods:publisher"/>
                    <xsl:if test="mods:originInfo/mods:place">
                        <!-- Remove , State from most fields -->
                        <mods:place>
                            <xsl:for-each select="mods:originInfo/mods:place/mods:placeTerm">
                                <xsl:if test=".[@type='code']">
                                    <xsl:if test="contains(., 'ctu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Connecticut</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'flu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Florida</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'gu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Guam</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'gw')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Germany</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'ilu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Illinois</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'inu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Indiana</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'mau')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Massachusetts</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'mdu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Maryland</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'meu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Maine</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'myu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>New York</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'nju')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>New Jersey</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'nyu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>New York</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'pau')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Pennsylvania</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>
                                    <xsl:if test="contains(., 'wiu')">

                                        <mods:placeTerm authority="marccountry" type="text">
                                            <xsl:text>Wisconsin</xsl:text>
                                        </mods:placeTerm>

                                    </xsl:if>

                                </xsl:if>
                                <xsl:if test=".[@type='text']">

                                    <xsl:copy-of select="."/>

                                </xsl:if>

                            </xsl:for-each>
                        </mods:place>
                    </xsl:if>
                </mods:originInfo>
            </xsl:if>

            <xsl:if test="mods:language">
                <mods:language>
                    <xsl:for-each select="mods:language/mods:languageTerm">
                        <xsl:if test="contains(., 'heb')">
                            <mods:languageTerm authority="iso639-2b" type="text">Hebrew</mods:languageTerm>
                        </xsl:if>
                        <xsl:if test="contains(., 'eng')">
                            <mods:languageTerm authority="iso639-2b" type="text">English</mods:languageTerm>
                        </xsl:if>
                        <xsl:if test="contains(., 'English')">
                            <xsl:copy-of select="."/>
                        </xsl:if>
                        <xsl:if test="contains(., 'Hebrew')">
                            <xsl:copy-of select="."/>
                        </xsl:if>
                    </xsl:for-each>
                </mods:language>
            </xsl:if>
            <xsl:copy-of select="mods:physicalDescription"/>
            <xsl:copy-of select="mods:abstract"/>
            <xsl:copy-of select="mods:tableOfContents"/>
            <xsl:copy-of select="mods:targetAudience"/>
            <xsl:copy-of select="mods:note"/>
            <xsl:copy-of select="mods:subject"/>
            <xsl:copy-of select="mods:classification"/>
            <!-- Need to remove Brown specific info and replace it with NU collection information -->
            <xsl:copy-of select="mods:relatedItem"/>
            <xsl:copy-of select="mods:identifier"/>
            <xsl:copy-of select="mods:location"/>
            <xsl:copy-of select="mods:accessCondition"/>
            <xsl:copy-of select="mods:part"/>
            <xsl:copy-of select="mods:extension"/>
            <mods:recordInfo>
                <mods:recordContentSource>Northeastern University Libraries</mods:recordContentSource>
                <mods:recordOrigin>MODS records were migrated from the Brown Digital Repository and updated according to Northeastern cataloging standards.</mods:recordOrigin>
                <mods:languageOfCataloging>
                    <mods:languageTerm authority="iso639-2b" authorityURI="http://id.loc.gov/vocabulary/iso639-2" valueURI="http://id.loc.gov/vocabulary/iso639-2/eng" type="text">English</mods:languageTerm>
                </mods:languageOfCataloging>
                <mods:descriptionStandard authority="marcdescription">local</mods:descriptionStandard>
            </mods:recordInfo>
        </mods:mods>
    </xsl:template>

</xsl:stylesheet>

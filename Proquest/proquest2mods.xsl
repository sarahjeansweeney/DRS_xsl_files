<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="DISS_submission">
        <mods:mods xmlns:mods="http://www.loc.gov/mods/v3"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
            
            <!--Stylesheet for mapping Proquest DISS Electronic Theses/Dissertations to MODS -->
           
            <mods:titleInfo>
                <mods:title>
                    <xsl:apply-templates select="DISS_description/DISS_title"/>
                </mods:title>
            </mods:titleInfo>
            
            <mods:titleInfo type="alternative">
                <mods:title>
                    <xsl:text></xsl:text>
                </mods:title>
            </mods:titleInfo>
            
            <xsl:for-each select="DISS_authorship/DISS_author | DISS_description/DISS_advisor | DISS_description/DISS_cmte_member">
                <mods:name type="personal">
                    <mods:namePart>
                        <xsl:value-of
                            select="DISS_name/DISS_surname"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="DISS_name/DISS_fname"/>
                        <xsl:if test="DISS_name/DISS_middle/text()"><xsl:text> </xsl:text>
                            <xsl:value-of select="DISS_name/DISS_middle"/>
                        </xsl:if>
                        <xsl:if test="DISS_name/DISS_suffix/text()">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="DISS_name/DISS_suffix"/>
                        </xsl:if>
                    </mods:namePart>
                    <mods:role>
                        <xsl:if test="self::DISS_author">
                            <mods:roleTerm type="text">Author</mods:roleTerm>
                        </xsl:if>
                        <xsl:if test="self::DISS_advisor">
                            <mods:roleTerm type="text">Advisor</mods:roleTerm>
                        </xsl:if>
                        <xsl:if test="self::DISS_cmte_member">
                            <mods:roleTerm type="text">Committee member</mods:roleTerm>
                        </xsl:if>
                    </mods:role>
                    <mods:affiliation>
                        <xsl:apply-templates select="DISS_name/DISS_affiliation"/>
                    </mods:affiliation>
                </mods:name>
            </xsl:for-each>
            
       
            <mods:typeOfResource>text</mods:typeOfResource>
            
            <mods:genre authority="aat"> 
                <xsl:for-each select="DISS_description/DISS_degree">
                    <xsl:choose>
                        <xsl:when test="matches(text(),'PhD') or matches(text(),'Ph.D') or matches(text(),'Ph.D.') or matches(text(),'Doctorate') or matches(text(),'doctorate')">
                            <xsl:text>dissertations</xsl:text>
                        </xsl:when>
                        
                        <xsl:when test="matches(text(),'M.S.') or matches(text(),'MS') or matches(text(),'M.S') or matches(text(),'Masters') or matches(text(),'masters') or matches(text(),'Master')
                            or matches(text(),'master')">
                            <xsl:text>theses</xsl:text>
                        </xsl:when>
                        
                        <xsl:otherwise>
                            <xsl:text>other</xsl:text>
                        </xsl:otherwise>
                        
                    </xsl:choose>
                </xsl:for-each>
            </mods:genre>
            
            <mods:originInfo> 
                <mods:place>
                    <mods:placeTerm type="text">Boston (Mass.)</mods:placeTerm>
                </mods:place>
                
                <xsl:for-each select="DISS_description/DISS_institution/DISS_inst_name">
                    <mods:publisher>
                        <xsl:value-of select="."/>
                    </mods:publisher>
                </xsl:for-each>
                
                <xsl:for-each select="DISS_description/DISS_dates/DISS_comp_date">
                    <mods:copyrightDate encoding="w3cdtf" keyDate="yes">
                        <xsl:value-of select="."/>
                    </mods:copyrightDate>
                </xsl:for-each>      
                
                <!-- Alternate mapping from DISS_accept_date to mods:copyrightDate; not sure which date should be used - DISS_accept_date or DISS_comp_date?
             
                <mods:copyrightDate>
                    <xsl:value-of
                        select="replace(DISS_description/DISS_dates/DISS_accept_date, '^(\d+)/(\d+)/(\d+)$', '$3-$2-$1')"/>
                </mods:copyrightDate>     -->
            </mods:originInfo>
            
            <mods:language>
                <mods:languageTerm authority="iso639-2b" type="code">eng</mods:languageTerm>
            </mods:language>
            
            <mods:physicalDescription>
                <mods:form authority="marcform">electronic</mods:form>
                <mods:digitalOrigin>born digital</mods:digitalOrigin>
            </mods:physicalDescription>
            
          <!--Revisions?  -->
            <mods:abstract>            <!-- xmlns="http://purl.org/dc/elements/1.1/ -->
                <xsl:value-of select="DISS_content/DISS_abstract"/>
            </mods:abstract>
                
            <mods:note>
                <xsl:text></xsl:text>
            </mods:note>
          
            <mods:subject>
                
               <!-- 
                <xsl:for-each select="DISS_description/DISS_categorization/DISS_keyword">
                    <mods:topic>
                        <xsl:value-of select="."/>
                    </mods:topic>
                </xsl:for-each>    -->
                
                <xsl:call-template name="keywordsplitter1">
                    <xsl:with-param name="keyword" select="DISS_description/DISS_categorization/DISS_keyword"/>
                </xsl:call-template>
                
                <xsl:call-template name="keywordsplitter2">
                    <xsl:with-param name="keyword" select="DISS_description/DISS_categorization/DISS_keyword"/>
                </xsl:call-template>
            
            
                <mods:topic authority="lcsh">
                    <xsl:text></xsl:text>
                </mods:topic>
                          
                <xsl:for-each select="DISS_description/DISS_categorization/DISS_category/DISS_cat_desc">
                    <mods:topic authority="discipline">
                        <xsl:value-of select="."/>
                    </mods:topic>
                </xsl:for-each>
            </mods:subject> 
            
          <!--Revisions?  -->
            <mods:identifier type="hdl">
                <xsl:text></xsl:text>
            </mods:identifier>
            
            <mods:extension xmlns:etd="http://www.ntltd.org/standards/metadata/etdms/1.0/etdms.xsd">
                <xsl:for-each select="DISS_description/DISS_institution/DISS_inst_name">
                    <etd:degree>
                        <etd:grantor>
                            <xsl:text>Northeastern University</xsl:text>
                        </etd:grantor>
                    </etd:degree> 
                </xsl:for-each>  
                          
                <xsl:for-each select="DISS_description/DISS_degree"> 
                    <etd:degree>
                        <etd:level>
                            <xsl:value-of select="."/>
                        </etd:level>
                    </etd:degree> 
                </xsl:for-each>
                
                <etd:degree>
                        <etd:name>
                            <xsl:text></xsl:text>
                        </etd:name>
                </etd:degree> 
                           
                <etd:degree>
                        <etd:discipline>
                            <xsl:value-of select="concat(DISS_description/DISS_institution/DISS_inst_name,' ; ',DISS_description/DISS_institution/DISS_inst_contact)"/>
                        </etd:discipline>
                    </etd:degree> 
             </mods:extension>
      
        </mods:mods>
    </xsl:template>
    
    <xsl:template name="keywordsplitter1">
        <xsl:param name="keyword"/>
        <xsl:choose>
            <xsl:when test="contains($keyword,';')">
                <mods:topic>
                        <xsl:value-of select="normalize-space(substring-before($keyword,';'))"/> 
                </mods:topic>
               
                <xsl:call-template name="keywordsplitter1">
                    <xsl:with-param name="keyword" select="substring-after($keyword,';')"/>
                </xsl:call-template>
             </xsl:when>
            
            <xsl:otherwise>
                 <mods:topic>
                        <xsl:value-of select="normalize-space($keyword)"/>
                 </mods:topic>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="keywordsplitter2">
        <xsl:param name="keyword"/>
        <xsl:choose>
            <xsl:when test="contains($keyword,',')">
                    <mods:topic>
                        <xsl:value-of select="normalize-space(substring-before($keyword,','))"/> 
                    </mods:topic>
                 
                <xsl:call-template name="keywordsplitter2">
                    <xsl:with-param name="keyword" select="substring-after($keyword,',')"/>             
                </xsl:call-template>         
            </xsl:when>
            
            <xsl:otherwise>             
                 <mods:topic>
                        <xsl:value-of select="normalize-space($keyword)"/>
                 </mods:topic>                       
            </xsl:otherwise>
        </xsl:choose>     
    </xsl:template>
</xsl:stylesheet>
    
 

<!-- Ignore this section: Alternate mapping for name fields   
            
            <xsl:for-each select="DISS_authorship/DISS_author/DISS_name">
                <mods:name type="personal" authority="local">
                    <mods:namePart>
                        <xsl:value-of select="DISS_surname"/>
                        <xsl:text>, </xsl:text>
                        
                        <xsl:if test="DISS_fname">
                            <xsl:value-of select="DISS_fname"/>
                        </xsl:if>
                        
                        <xsl:if test="DISS_middle">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="DISS_middle"/>
                        </xsl:if>
                    
                     Remove DISS_suffix 
                        <xsl:if test="DISS_suffix">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="DISS_suffix"/>
                        </xsl:if>       
                    </mods:namePart>   
                    
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="text">Author</mods:roleTerm> 
                    </mods:role>     
                    
                    <xsl:if test="DISS_affiliation">
                        <mods:affiliation>
                            <xsl:value-of select="DISS_affiliation"/>
                        </mods:affiliation>
                    </xsl:if>
                </mods:name>
            </xsl:for-each>   
            
            <xsl:for-each select="DISS_description/DISS_advisor/DISS_name">
                <mods:name type="personal" authority="local">
                    <mods:namePart>
                        <xsl:value-of select="DISS_surname"/>
                        <xsl:text>, </xsl:text>
                        
                        <xsl:if test="DISS_fname">
                            <xsl:value-of select="DISS_fname"/>
                        </xsl:if>
                        
                        <xsl:if test="DISS_middle">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="DISS_middle"/>
                        </xsl:if>
                        
                     Remove DISS_suffix     
                        <xsl:if test="DISS_suffix">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="DISS_suffix"/>
                        </xsl:if>     
                    </mods:namePart>
                    
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="text">Advisor</mods:roleTerm> 
                    </mods:role>
                    
                    <xsl:if test="DISS_affiliation">
                        <mods:affiliation>
                            <xsl:value-of select="DISS_affiliation"/>
                        </mods:affiliation>
                    </xsl:if>
                </mods:name>
            </xsl:for-each>
            
            <xsl:for-each select="DISS_description/DISS_cmte_member/DISS_name">
                <mods:name type="personal" authority="local">
                    <mods:namePart>
                        <xsl:value-of select="DISS_surname"/>
                        <xsl:text>, </xsl:text>
                        
                        <xsl:if test="DISS_fname">
                            <xsl:value-of select="DISS_fname"/>
                        </xsl:if>
                        
                        <xsl:if test="DISS_middle">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="DISS_middle"/>
                        </xsl:if>
                        
                     Remove DISS_suffix      
                        <xsl:if test="DISS_suffix">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="DISS_suffix"/>
                        </xsl:if>        
                    </mods:namePart>
                    
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="text">Committee member</mods:roleTerm> 
                    </mods:role>
                    
                    <xsl:if test="DISS_affiliation">
                        <mods:affiliation>
                            <xsl:value-of select="DISS_affiliation"/>
                        </mods:affiliation>
                    </xsl:if>
                </mods:name>
            </xsl:for-each>         -->
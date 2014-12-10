<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes" method="xml"/>
       <xsl:template match="/DirectoryMetadata/FileSet">
         <mods:mods xmlns:mods="http://www.loc.gov/mods/v3"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
            
            <xsl:for-each select="Description/Metadata[@name='nuhistph.Title']">
                <mods:titleInfo>
                    <mods:title>
                        <xsl:value-of select="."/>
                    </mods:title>
                </mods:titleInfo>
            </xsl:for-each>
            
            <!-- Creator field from input XML contains both Personal Names and Corporate Names; review metadata post-stylesheet to differentiate between Personal Names and Corporate Names (as defined in the 
                NU Historical Photographs data dictionary). -->
            
            <xsl:for-each select="Description/Metadata[@name='nuhistph.Creator']">
                <mods:name authority="local">
                    <mods:namePart>
                        <xsl:value-of select="."/>
                    </mods:namePart>
                    <mods:role>
                        <mods:roleTerm authority="marcrelator" type="text">Photographer</mods:roleTerm> 
                    </mods:role>
                </mods:name>
            </xsl:for-each>
            
            <!-- MODS typeofResource values: text, cartographic, notated music, sound recording-musical, sound recording-nonmusical, sound recording, still image, moving image, three dimensional object, software, multimedia, mixed material  -->
            
            <mods:typeOfResource>still image</mods:typeOfResource>
            
            <mods:genre authority="aat">photographs</mods:genre>
            
            
            <!--Problems with Date_Created formatting in source XML; some have ca. YYYY format; some have "n.d." format; some have YYYY-MM-DD or YYYY-MM or YYYY format. Patrick can write script to normalize
            some or all date formats. -->
            
            <mods:originInfo>
                <xsl:for-each select="Description/Metadata[@name='nuhistph.DateCreated']">
                    <mods:dateCreated encoding="w3cdtf" keyDate="yes">
                        <xsl:value-of select="."/>
                    </mods:dateCreated>
                </xsl:for-each>
                
                <xsl:for-each select="Description/Metadata[@name='nuhistph.DateAvailable']">
                    <mods:dateValid encoding="w3cdtf">
                        <xsl:value-of select="."/>
                    </mods:dateValid>
                </xsl:for-each>
            </mods:originInfo>
            
            <!-- Since this is a photograph collection and doesn't contain text, mods:language may not be necessary 
           
            <mods:language>
                <mods:languageTerm authority="iso639-2b">eng</mods:languageTerm>
            </mods:language>            -->
            
            <!--All input XML seems to include either 1 or 2 'nuhistph.RelationIsFormatOf' fields; If item was digitized, there are usually two 'nuhistph.RelationIsFormatOf' fields - one contains physical format
            information such as "Black and White Print" and the other includes physical dimensions such as "8 x 5 inches". If item was born digital, there are also two 'nuhistph.RelationIsFormatOf'
            fields. However, the first has metadata "Digital image - jpeg" and the second is empty / no metadata value. 
            
            Furthermore, the metadata formatting for the 'nuhistph.RelationIsFormatOf' fields is inconsistent. Data values include "Black & white print", "Black and white print", "8 x 5 inches", "8 x 5 in.", "8 x 5". --> 
            
            <mods:physicalDescription>
                <!-- MARC form if items term list: braille, electronic, microfiche, microfilm, print, large print  -->
                <mods:form authority="marcform">electronic</mods:form>   
                
                <xsl:for-each select="Description/Metadata[@name='nuhistph.RelationIsFormatOf']">
                    <mods:extent>
                        <xsl:value-of select="."/>
                    </mods:extent>
                </xsl:for-each>
                
             <!-- Instead of two <extent> fields for each nuhistph.RelationIsFormatOf field, we could combine each nuhistph.RelationIsFormatOf field into a single <extent> field separated by a semi-colon. However, this
             doesn't work when the input file is for a born digital item record because only the first nuhistph.RelationIsFormatOf field is populated, the second is empty. So the output metadata
             ends up looking like this: Digital file - jpeg ; 
               
               <mods:extent> 
                    <xsl:value-of select="concat(Description/Metadata[@name='nuhistph.RelationIsFormatOf'][1],' ; ',Description/Metadata[@name='nuhistph.RelationIsFormatOf'][2])" />
               </mods:extent>    -->
                
                <!-- MODS physicaDescription <digitalOrigin> values: born digital, reformatted digital, digitized microfilm, digitized other analog -->
                <xsl:for-each select="Description/Metadata[@name='nuhistph.RelationIsFormatOf']">
                        <xsl:choose>
                            <xsl:when test="contains(text(),'Digital') or contains(text(),'digital')">
                                <mods:digitalOrigin>
                                    <xsl:text>born digital</xsl:text>
                                </mods:digitalOrigin>
                            </xsl:when>
                       
                            <xsl:when test="contains(text(),'Print') or contains(text(),'print') or contains(text(),'Negative') or contains(text(),'negative') or contains(text(),'Sheet') or contains(text(),'sheet')
                                or contains(text(),'Plate') or contains(text(),'plate') or contains(text(),'Slide') or contains(text(),'slide') or contains(text(),'Transparency') or contains(text(),'transparency')
                                or contains(text(),'Yearbook') or contains(text(),'yearbook') or contains(text(),'Book') or contains(text(),'book')">
                                <mods:digitalOrigin>
                                    <xsl:text>reformatted digital</xsl:text>
                                </mods:digitalOrigin>
                            </xsl:when>
                        </xsl:choose>
                 </xsl:for-each>
            
            </mods:physicalDescription>
            
            
            <!--Some input XML records provide Collection Name in the 'nuhistph.RelationIsPartOf' field, others include a browse tree for the digital or physical collection, eg. "Events > Commencement > 
            Honorary Degree Recipients > 6/21/1982"
            or eg. "Physical Plant > Aerial Views > Huntington Campus > 1990s" and/or other organizational information such as "A59" and/or "Box 10, Folder 10". XSL can divide the 'nuhistph.RelationIsPartOf' field into separate fields in MODS; 
            scripting/manual post-migration editing probably not needed. -->
                
              
            <xsl:for-each select="Description/Metadata[@name='nuhistph.RelationIsPartOf']">
                    <xsl:choose>
                        
                        <xsl:when test="contains(text(),'Photograph Collection') or contains(text(),'photograph collection') or contains(text(),'Photograph collection') or contains(text(),'photograph Collection')">
                            <mods:note type="collection_name">
                                <xsl:value-of select="."/>
                            </mods:note>
                    </xsl:when>
                        
                        <xsl:when test="contains(text(),' > ')">
                            <mods:note type="facet">
                                <xsl:value-of select="."/>
                            </mods:note>
                        </xsl:when>
                     
                    <xsl:otherwise>
                              <mods:note type="organization_of_materials">
                                <xsl:value-of select="."/>
                              </mods:note>
                    </xsl:otherwise>
                        
                    </xsl:choose>
            </xsl:for-each>

           
               
            <xsl:for-each select="Description/Metadata[@name='nuhistph.Description']">
                 <mods:note type="description">
                    <xsl:value-of select="."/>
                 </mods:note>
            </xsl:for-each>
            
            <!-- Some input records have nuhistph.Provenance and nuhistph.RightsRightsHolder fields that both contain provenance information, although nuhistph.Provenance usually has a name and nuhistph.RightsRightsHolder is usually 
            written as a sentence but contains the same name data. In this case, nuhistph.RightsRightsHolder should be migrated and not nuhistph.Provenance. However, not sure how to do this with XSL.
            Some records lack a nuhistph.RightsRightsHolder, but have a nuhistph.Provenance field. Thus, the nuhistph.Provenance field should be migrated. Furthermore, some records have a nuhistph.RightsRightsHolder field while others do not have
            a nuhistph.Provenance field. Therefore, nuhistph.RightsRightsHolder needs to be migrated to output record (See below mapping of nuhistph.RightsRightsHolder to mods:note type="provenance"). -->
            
            <xsl:for-each select="Description/Metadata[@name='nuhistph.Provenance']">
                <mods:note type="provenance">
                    <xsl:value-of select="."/>
                </mods:note>
            </xsl:for-each>
            
            
            <!--Some nuhistph.RightsRightsHolder fields contain "provenance" information, others contain "copyright" information. If the field contains "provenance information", then the 'nuhistph.Provenance' field that 
            is mapped to <mods:note type="provenance"> may need to be deleted. Not sure if scripting can be helpful in this case, may need to edit/update/delete manually after migration. -->
                
            <xsl:for-each select="Description/Metadata[@name='nuhistph.RightsRightsHolder']">
                    <xsl:choose>
                        
                    <xsl:when test="contains(text(),'contributed') or contains(text(),'Contributed') or contains(text(),'donated') or contains(text(),'Donated')">
                             <mods:note type="provenance">
                                   <xsl:value-of select="."/>
                             </mods:note>
                    </xsl:when>  
                  
                  <!-- Probably don't need to include rights_holder in DRS records
                    <xsl:otherwise>
                              <mods:accessCondition type="rights_holder">
                                    <xsl:value-of select="."/>
                              </mods:accessCondition>
                    </xsl:otherwise>    -->
                        
                    </xsl:choose>
             </xsl:for-each>

         
            <!-- LCSH subject headings with dashes may need to be modified/edited. Whitespace between headings and dashes may or may not create problems with MODS / Fedora. -->

            <mods:subject>
                <xsl:for-each select="Description/Metadata[@name='nuhistph.Subject']">
                    <mods:topic authority="lcsh">
                        <xsl:value-of select="."/>
                    </mods:topic>
                </xsl:for-each>
                
                
                <!-- Input XML records often use nuhistph.Coverage.Spatial for corporate names such as "Symphony Hall (Boston, Mass.)" or "Marriott Hotel (Newton, Mass.)"; less often, they are used for the intended purpose 
                    such as "Great Brewster Island (Boston, Mass.)" Probably will need to perform manual clean-up post migration/mapping to move the corporate names to <subject> <name type="corporate"> field. -->
                    
                <xsl:for-each select="Description/Metadata[@name='nuhistph.Coverage.Spatial']">
                    <mods:geographic authority="local">
                        <xsl:value-of select="."/>
                    </mods:geographic>
                </xsl:for-each>           
                
                
                <xsl:for-each select="Description/Metadata[@name='nuhistph.subjectHeadingGroupNameTerm']">
                    <mods:name type="corporate" authority="local">
                        <mods:namePart>
                            <xsl:value-of select="."/>
                        </mods:namePart>
                    </mods:name>
                </xsl:for-each>
                
                <xsl:for-each select="Description/Metadata[@name='nuhistph.subjectHeadingPersonalNameTerm']">
                    <mods:name type="personal" authority="local">
                        <mods:namePart>
                            <xsl:value-of select="."/>
                        </mods:namePart>
                    </mods:name>
                </xsl:for-each>
            </mods:subject>
            
        </mods:mods>   
    </xsl:template>
</xsl:stylesheet>
           
          
            




<!-- Please ignore this section... alternate xsl for 'nuhistph.RelationIsFormatOf' field to <mods:physicalDescription> -->
           
   <!--         <mods:physicalDescription>  
               <xsl:for-each select="Description/Metadata[@name='nuhistph.RelationIsFormatOf']">
                    <xsl:choose>
                        
                    <xsl:when test="contains(text(),'Print') or contains(text(),'print')">
                            <mods:form>
                                <xsl:value-of select="."/>
                            </mods:form>
                    </xsl:when>
                        
                    <xsl:when test="contains(text(),'Digital') or contains(text(),'digital') or contains(text(),'image')">
                             <mods:digitalOrigin>
                                  <xsl:value-of select="."/>
                             </mods:digitalOrigin>
                    </xsl:when>  
                                            
                    <xsl:otherwise>
                              <mods:extent>
                                <xsl:value-of select="."/>
                              </mods:extent>
                    </xsl:otherwise>
                        
                    </xsl:choose>
                </xsl:for-each>
             </mods:physicalDescription>      -->
            
       
            
         


          
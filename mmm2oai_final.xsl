<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

    <!-- 
        ***********************************************************************************
        Copyright &#xa9; 2008 University of Nebraska 
        All rights reserved.
        
        Author: Center for Digital Research in the Humanties
        Date: 2009, 2010
        
        ***************************************************************************************
    -->

    <xsl:variable name="fileID">
        <xsl:value-of select="//*[not(parent::*)]/@id"/>
    </xsl:variable>

    <xsl:variable name="filename">
        <xsl:value-of select="//publicationStmt/child::idno"/>
    </xsl:variable>

    <xsl:template match="TEI">
        <oai_dc:dc>

            <xsl:apply-templates/>

<oai_dc:dc>

            <xsl:apply-templates/>

            <dc:format>Online resource</dc:format>
            <dc:language>English</dc:language>
            <!-- <dc:description>Full text transcription</dc:description> -->
            <dc:contributor>Seefeldt, Douglas, 1964-</dc:contributor>
            <dc:publisher>University of Nebraska--Lincoln, Center for Digital Research in the Humanities</dc:publisher>
            <dc:publisher>University of Virginia</dc:publisher>
            <dc:source>Envisaging the West: Thomas Jefferson and the Roots of Lewis and Clark, http://jeffersonswest.unl.edu/</dc:source>
            <dc:subject>Jefferson, Thomas, 1743-1826</dc:subject>
        </oai_dc:dc>

            <xsl:choose>
                <xsl:when test="not(descendant::bibl)">
                    <dc:title>
                        <xsl:value-of select="//titleStmt/title[@type='main']"/>

                        <xsl:if test="//keywords/term">
                            <xsl:text> [</xsl:text>
                            <xsl:value-of select="//keywords/term"/>
                            <xsl:text>]</xsl:text>
                        </xsl:if>

                    </dc:title>
                </xsl:when>
                <xsl:when test="descendant::bibl[parent::sourceDesc]">
                    <dc:title>

                        <xsl:if test="//sourceDesc/bibl/title[@level='a']">
                            <xsl:value-of select="//sourceDesc/bibl/title[@level='a']"/>
                            <xsl:text>, </xsl:text>
                        </xsl:if>

                        <xsl:if test="//sourceDesc/bibl/title[@level='j']">
                            <xsl:value-of select="//sourceDesc/bibl/title[@level='j']"/>
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="//sourceDesc/bibl/date/@value"/>
                        </xsl:if>
                        
                        <xsl:if test="//sourceDesc/bibl//title[@level='m']">
                            <xsl:value-of select="//sourceDesc/bibl//title[@level='m']"/>
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="//sourceDesc/bibl/date/@value"/>
                        </xsl:if>
                        
                        <xsl:if test="//keywords/term">
                            <xsl:text> [</xsl:text>
                            <xsl:value-of select="//keywords/term"/>
                            <xsl:text>]</xsl:text>
                        </xsl:if>

                    </dc:title>
                </xsl:when>

                <xsl:otherwise>
                    <dc:title>
                        <xsl:value-of select="//titleStmt/title[@type='main']"/>

                        <xsl:if test="//keywords/term">
                            <xsl:text> [</xsl:text>
                            <xsl:value-of select="//keywords/term"/>
                            <xsl:text>]</xsl:text>
                        </xsl:if>

                    </dc:title>
                </xsl:otherwise>
            </xsl:choose>
            <dc:format>Online resource</dc:format>
            <dc:language>English</dc:language>
            <dc:description>Full text transcription</dc:description>
            <dc:contributor>George-Bloomfield, Susanne, 1947-</dc:contributor>
            <dc:publisher>Plains Humanities Alliance</dc:publisher>
            <dc:publisher>University of Nebraska--Lincoln, Center for Digital Research in the Humanities</dc:publisher>
            <dc:source>Elia Peattie: An Uncommon Writer, An Uncommon Woman, http://plainshumanities.unl.edu/peattie</dc:source>
            <dc:subject>Peattie, Elia Wilkinson, 1862-1935</dc:subject>
        </oai_dc:dc>
    </xsl:template>

    <xsl:template match="fileDesc/titleStmt/author">
        <xsl:choose>
            <xsl:when test="normalize-space(.)">
                <dc:creator>
                    <xsl:value-of select="normalize-space(.)"/>
                </dc:creator>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="fileDesc/sourceDesc//date">
        <xsl:choose>
            <xsl:when test="@value">
                <dc:date>
                    <xsl:value-of select="//fileDesc/editionStmt/edition/date"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="substring(@value,1,4)"/>
                </dc:date>
            </xsl:when>
            <xsl:when test="@when and xs:integer(string-length(substring(@when,1,4))=4)">
                <dc:date>
                    <xsl:value-of select="substring(@when,1,4)"/>
                </dc:date>
            </xsl:when>
            <xsl:otherwise>
                <dc:date>
                    <xsl:value-of select="normalize-space(.)"/>
                </dc:date>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="fileDesc/editionStmt/edition/date">
        <dc:created>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:created>
    </xsl:template>

    <xsl:template match="fileDesc/publicationStmt/idno">
        <dc:identifier>http://plainshumanities.unl.edu/peattie/<xsl:value-of select="."/>.html</dc:identifier>
    </xsl:template>
    <xsl:template match="distributor">
        <dc:publisher>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:publisher>
    </xsl:template>

    <xsl:template match="keywords/term">
        <dc:type>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:type>
    </xsl:template>

    <xsl:template match="text()"/>
</xsl:stylesheet>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

    <!-- 
        ***********************************************************************************
        Copyright &#xa9; 2010 University of Nebraska 
        All rights reserved.
        
        Author: Center for Digital Research in the Humanties
        Date: 2010
        
        ***************************************************************************************
    -->

    <xsl:variable name="fileID">
        <xsl:value-of select="//*[not(parent::*)]/@id"/>
    </xsl:variable>

    <xsl:variable name="filename">
        <xsl:value-of select="/TEI.2/@id"/>
    </xsl:variable>


    <xsl:template match="TEI.2">
        <oai_dc:dc>

            <xsl:apply-templates/>
            <!-- these three lines are OK -->
            <dc:format>Online resource</dc:format>
            <dc:language>English</dc:language>
            <dc:publisher>University of Nebraska&#8211;Lincoln, Center for Digital Research in the
                Humanities</dc:publisher>

            <!-- start changes here -->

            <dc:contributor>Pratt, Linda Ray</dc:contributor>
            <dc:source>Writings of Thomas Wentworth Higginson,
                http://higginson.unl.edu/index.html</dc:source>
            <dc:subject>Higginson, Thomas Wentworth, 1823-1911</dc:subject>

            <xsl:choose>
                <xsl:when test="starts-with(//TEI.2/@id,'twh')">
                    <dc:identifier>http://higginson.unl.edu/writings/<xsl:value-of select="@id"
                    />.html</dc:identifier>
                </xsl:when>
                <xsl:otherwise>
                    <dc:identifier>http://higginson.unl.edu/letters/<xsl:value-of select="@id"
                    />.html</dc:identifier>
                </xsl:otherwise>
            </xsl:choose>

        </oai_dc:dc>
    </xsl:template>


    <xsl:template match="sourceDesc/bibl/title">
        <dc:title>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:title>
    </xsl:template>

    <xsl:template match="sourceDesc/bibl/notesStmt/note[@type='sentence']">
        <dc:description>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:description>
    </xsl:template>

    <xsl:template match="sourceDesc/bibl/notesStmt/note[@type='source']">
        <dc:source>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:source>
    </xsl:template>

    <xsl:template match="sourceDesc/biblFull/notesStmt/note[@type='cartographer']">
        <dc:contributor>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:contributor>
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


    <xsl:template match="fileDesc/publicationStmt/date">
        <dc:date>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:date>
    </xsl:template>

    <!-- Distributor
    <xsl:template match="distributor">
        <dc:publisher>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:publisher>
        
    </xsl:template>
-->

    <xsl:template match="text()"/>
</xsl:stylesheet>

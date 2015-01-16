<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.1">

<xsl:output method="xml" indent="yes" encoding="utf-8"/>

<xsl:strip-space elements="*"/> 


<xsl:variable name="filename"><xsl:value-of select="//publicationStmt/idno"/></xsl:variable>
<xsl:variable name="directoryname"><xsl:choose><xsl:when test="TEI.2[starts-with(@id,'lc.180')]">journal</xsl:when><xsl:otherwise><xsl:value-of select="//publicationStmt/idno"/></xsl:otherwise></xsl:choose></xsl:variable>
<xsl:variable name="date"><xsl:value-of select="//profileDesc//creation/date"/></xsl:variable>
<xsl:variable name="dateValue"><xsl:value-of select="//sourceDesc//date/attribute::value"/></xsl:variable>
<xsl:variable name="stylesheet">

</xsl:variable>



<xsl:template match="/">

<!-- 
<xsl:document href="U:/Encore/RDF/convertedrdf/{$filename}.rdf" method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="no">
 -->

<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
         xmlns:role="http://www.loc.gov/loc.terms/relators/"
         xmlns:dc="http://purl.org/dc/elements/1.1/"
         xmlns:dcterms="http://purl.org/dc/terms/"
         xmlns:nines="http://www.nines.org/schema#"
         xmlns:jef="http://jeffersonswest.unl.edu/schema#">
   
  <jef:writings>


<xsl:attribute name="rdf:about">http://jeffersonswest.unl.edu/<xsl:value-of select="$filename"/></xsl:attribute>

      <nines:archive>jeffersonswest</nines:archive>
  <rdfs:seeAlso>
   <xsl:attribute name="rdf:resource">http://jeffersonswest.unl.edu/archive/view_doc.php?id=<xsl:value-of select="//*[not(parent::*)]/@id"/></xsl:attribute>

	</rdfs:seeAlso>

   <dc:title><xsl:value-of select="//sourceDesc//biblFull//notesStmt//note[@type='label']"/></dc:title>



<xsl:choose>
<xsl:when test="//biblFull//titleStmt//author">
<xsl:for-each select="//biblFull/titleStmt//author"><role:AUT><xsl:value-of select="."/></role:AUT></xsl:for-each>
</xsl:when>

<xsl:otherwise></xsl:otherwise>
</xsl:choose>


<xsl:choose>
<xsl:when test="//monogr//editor">
<xsl:for-each select="//monogr//editor"><role:EDT><xsl:value-of select="."/></role:EDT></xsl:for-each>
</xsl:when>

<xsl:otherwise></xsl:otherwise>
</xsl:choose>

<xsl:choose>
 <xsl:when test="//profileDesc//creation//date">
<xsl:for-each select="//profileDesc//creation//date"><dc:date>
            <xsl:value-of select="normalize-space(.)"/>
        </dc:date></xsl:for-each>
</xsl:when>
</xsl:choose>
   
   
<xsl:choose>
<xsl:when test="//TEI.2[starts-with(@id,'jef.map')]">
      <nines:genre>Nonfiction</nines:genre>
      <nines:genre>History</nines:genre>
      <nines:genre>Primary</nines:genre>
      <nines:genre>Map</nines:genre>
</xsl:when>

<xsl:otherwise>
      <nines:genre>Primary</nines:genre>
      <nines:genre>Nonfiction</nines:genre>
      <nines:genre>Letter</nines:genre>
</xsl:otherwise>
</xsl:choose>

 <nines:text>
	 <xsl:attribute name="rdf:resource">http://jeffersonswest.unl.edu/texts/<xsl:value-of select="$filename"/>.txt</xsl:attribute>
</nines:text>
  </jef:writings>

</rdf:RDF>


</xsl:template>



</xsl:stylesheet>
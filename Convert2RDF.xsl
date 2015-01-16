<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<xsl:output method="xml" indent="yes" encoding="utf-8"/>

<xsl:strip-space elements="*"/> 

<!-- output file -->

<xsl:variable name="filename"><xsl:value-of select="//TEI.2/@id"/></xsl:variable>

<xsl:template match="/">

<xsl:result-document href="{$filename}.rdf" method="xml" encoding="utf-8" xml:space="default">

<!-- root element -->

<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
xmlns:role="http://www.loc.gov/loc.terms/relators/"
xmlns:dc="http://purl.org/dc/elements/1.1/"
xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:nines="http://www.nines.org/schema#"
xmlns:lc="http://lewisandclarkjournals.unl.edu/schema#">
   
<lc:writings>
<xsl:attribute name="rdf:about">http://lewisandclarkjournals.unl.edu/<xsl:value-of select="$filename"/></xsl:attribute>

<!-- contributing project -->

<nines:archive>lewisandclark</nines:archive>

<!-- see also -->

<rdfs:seeAlso>
<xsl:attribute name="rdf:resource">http://libtextcenter.unl.edu/examples/servlet/transform/tamino/Library/lewisandclarkjournals?&amp;_xmlsrc=http://libtextcenter.unl.edu/lewisandclark/files/xml/<xsl:value-of select="$filename"/>.xml&amp;_xslsrc=http://libtextcenter.unl.edu/lewisandclark/LCstyles.xsl</xsl:attribute>

</rdfs:seeAlso>

<!-- title -->

<dc:title><xsl:apply-templates select="//titleStmt/title[@type='main']"/><xsl:text>&#x0020;</xsl:text><xsl:apply-templates select="//titleStmt/title[@type='sub']"/></dc:title>

<!-- author -->

<xsl:for-each select="//text/body/div1/sp">
<xsl:variable name="speaker" select="./@who"/>
<role:AUT><xsl:value-of select="//handList/hand[@id=$speaker]/@scribe"/></role:AUT></xsl:for-each>

<!-- editor -->

<xsl:choose>
<xsl:when test="//monogr//editor">
<xsl:for-each select="(//monogr//editor)[1]"><role:EDT><xsl:value-of select="."/></role:EDT></xsl:for-each>
</xsl:when>

<xsl:otherwise></xsl:otherwise>
</xsl:choose>

<!-- date -->

<dc:date>
<nines:date>
<rdfs:label><xsl:apply-templates select="//titleStmt/title[@type='sub']"/></rdfs:label>
<rdf:value><xsl:value-of select="substring(//text/body/head/date/@value, 1, 4)"/></rdf:value>
</nines:date>
</dc:date>

<!-- genre -->

<xsl:choose>
<xsl:when test="//TEI.2[starts-with(@id,'lc.180')]">
<nines:genre>Nonfiction</nines:genre>
<nines:genre>History</nines:genre>
<nines:genre>Primary</nines:genre>
<nines:genre>Secondary</nines:genre>
<nines:genre>Paratext</nines:genre>
</xsl:when>

<xsl:otherwise>
<nines:genre>Nonfiction</nines:genre>
<nines:genre>History</nines:genre>
<nines:genre>Secondary</nines:genre>
</xsl:otherwise>
</xsl:choose>

<!-- text -->

<nines:text>
<xsl:attribute name="rdf:resource">http://lewisandclarkjournals.unl.edu/texts/<xsl:value-of select="$filename"/>.txt</xsl:attribute>
</nines:text>


</lc:writings>
</rdf:RDF>

</xsl:result-document>


</xsl:template>
</xsl:stylesheet>
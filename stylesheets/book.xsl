<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns="http://docbook.org/ns/docbook"
 xmlns:ol="http://openlyrics.info/namespace/2009/song"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:str="http://exslt.org/strings"
 xmlns:xi="http://www.w3.org/2001/XInclude"
 xmlns:db="http://docbook.org/ns/docbook"
 xmlns:xhtml="http://www.w3.org/1999/xhtml">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>

  <xsl:param name="source-path"/>

  <xsl:template match="/">
    <xsl:processing-instruction name="xml-stylesheet">
      <xsl:text>href="../stylesheets/book.css" type="text/css"</xsl:text>
    </xsl:processing-instruction>
    <xsl:text>&#x0A;</xsl:text>
    <book>
    <xsl:apply-templates />
    </book>
  </xsl:template>

  <xsl:template match="db:toc">
    <db:toc>
      <xsl:for-each select="../xi:include">
        <xsl:variable name="url">
          <xsl:choose>
            <xsl:when test="system-property('xsl:vendor')='Transformiix'"><xsl:value-of select="concat('../', @href)"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="concat($source-path, str:encode-uri(@href, true()))"/></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="song" select="document ($url)/ol:song" />
        <xsl:variable name="title" select="../db:title/text()" />
        <db:entry><xhtml:a href="#{../db:title/@id}-{$song/ol:properties/ol:songbooks/ol:songbook[@name=$title]/@entry}"><xsl:value-of select="$song/ol:properties/ol:titles/ol:title[1]" /></xhtml:a></db:entry>
      </xsl:for-each>
    </db:toc>
  </xsl:template>

  <xsl:template match="xi:include">
    <xsl:variable name="url">
      <xsl:choose>
        <xsl:when test="system-property('xsl:vendor')='Transformiix'"><xsl:value-of select="concat('../', @href)"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="concat($source-path, str:encode-uri(@href, true()))"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="song" select="document ($url)/ol:song" />
    <xsl:variable name="title" select="../db:title/text()" />
    <xsl:element name="song" namespace="http://openlyrics.info/namespace/2009/song">
      <xsl:attribute name="xml:lang"><xsl:value-of select="$song/@xml:lang" /></xsl:attribute>
      <xsl:attribute name="version"><xsl:value-of select="$song/@version" /></xsl:attribute>
      <xsl:attribute name="chordnotation"><xsl:value-of select="/db:book/@chordnotation" /></xsl:attribute>
      <xsl:attribute name="createdIn"><xsl:value-of select="$song/@createdIn" /></xsl:attribute>
      <xsl:attribute name="modifiedIn"><xsl:value-of select="$song/@modifiedIn" /></xsl:attribute>
      <xsl:attribute name="modifiedDate"><xsl:value-of select="$song/@modifiedDate" /></xsl:attribute>
      <xsl:attribute name="id"><xsl:value-of select="concat(../db:title/@id, '-', $song/ol:properties/ol:songbooks/ol:songbook[@name=$title]/@entry)" /></xsl:attribute>
      <xsl:copy-of select="$song/ol:properties" />
      <xsl:copy-of select="$song/ol:lyrics" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="db:title|db:foreword">
    <xsl:copy-of select="."/>
  </xsl:template>

</xsl:stylesheet>

